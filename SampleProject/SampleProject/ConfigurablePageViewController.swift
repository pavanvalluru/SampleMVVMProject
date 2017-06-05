//
//  ConfigurablePageViewController.swift
//  Configurable3
//
//  Created by Pavan Kumar Valluru on 11.04.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import UIKit

protocol ConfigurablePageViewControllerDelegate: UIPageViewControllerDelegate {
    
}

protocol ConfigurablePageViewControllerScrollDelegate: UIScrollViewDelegate {
    
}

protocol ConfigurablePageViewControllerDataSource: UIPageViewControllerDataSource {
    
}

protocol ConfigurablePageViewControllerCustomProtocol: class {
    
    /**
     Called when the number of pages is updated.
     
     - parameter configurablePageViewController: the ConfigurablePageViewController instance
     - parameter count: the total number of pages.
     */
    func configurablePageViewController(_ configurablePageViewController: ConfigurablePageViewController,
                                    didUpdatePageCount count: Int)
    
    /**
     Called when the current index is updated.
     
     - parameter configurablePageViewController: the ConfigurablePageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func configurablePageViewController(_ configurablePageViewController: ConfigurablePageViewController,
                                    didUpdatePageIndex index: Int)
    
}

extension ConfigurablePageViewControllerCustomProtocol
{
    func configurablePageViewController(_ configurablePageViewController: ConfigurablePageViewController, didUpdatePageCount count: Int) {
        
        UIPageControl.appearance().numberOfPages = count
    }
    
    func configurablePageViewController(_ configurablePageViewController: ConfigurablePageViewController, didUpdatePageIndex index: Int) {
        
        UIPageControl.appearance().currentPage = index
    }
    
}

class ConfigurablePageViewController: UIPageViewController {
    
    var pageViewDelegate: ConfigurablePageViewControllerCustomProtocol?
    var scrollView: UIScrollView!
    
    var currentIndex = 0 // default index that needs to be shown
    
    var newIndex = 1
    var startedToRightSide = false
    var lastXPos: CGFloat = 0
    
    var showStatusBar = true
    
    lazy var orderedViewControllers: [UIViewController] = [UIViewController()]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        scrollView = view.subviews.filter { $0 is UIScrollView }.first as! UIScrollView
        scrollView.delegate = self
        self.automaticallyAdjustsScrollViewInsets = true
        
        scrollToViewController(orderedViewControllers[currentIndex])
        
        pageViewDelegate?.configurablePageViewController(self, didUpdatePageCount: orderedViewControllers.count)
    }
    
    override var prefersStatusBarHidden : Bool {
        return !showStatusBar
    }
    
    /**
     Scrolls to the next view controller.
     */
    func scrollToNextViewController() {
        if let visibleViewController = viewControllers?.first,
            let nextViewController = pageViewController(self, viewControllerAfter: visibleViewController) {
            scrollToViewController(nextViewController)
        }
    }
    
    /**
     Scrolls to the view controller at the given index. Automatically calculates
     the direction.
     
     - parameter newIndex: the new index to scroll to
     */
    func scrollToViewController(index newIndex: Int)
    {
        if let firstViewController = viewControllers?.first,
            let currentIndex = orderedViewControllers.index(of: firstViewController) {
            let direction: UIPageViewControllerNavigationDirection = newIndex >= currentIndex ? .forward : .reverse
            let nextViewController = orderedViewControllers[newIndex]
            scrollToViewController(nextViewController, direction: direction)
            self.notifyConfigurableDelegateOfNewIndex()
        }
    }
    
    /**
     Scrolls to the given 'viewController' page.
     
     - parameter viewController: the view controller to show.
     */
    func scrollToViewController(_ viewController: UIViewController,
                                direction: UIPageViewControllerNavigationDirection = .forward) {
        setViewControllers([viewController],
                           direction: direction,
                           animated: true,
                           completion: { (finished) -> Void in
                            // Setting the view controller programmatically does not fire
                            // any delegate methods, so we have to manually notify the
                            // 'configurableDelegate' of the new index.
                            
                            self.notifyConfigurableDelegateOfNewIndex()
        })
    }
    
    /**
     Notifies '_configurableDelegate' that the current page index was updated.
     */
    func notifyConfigurableDelegateOfNewIndex() {
        if let firstViewController = viewControllers?.first,
            let index = orderedViewControllers.index(of: firstViewController) {
            pageViewDelegate?.configurablePageViewController(self, didUpdatePageIndex: index)
            self.currentIndex = index
        }
    }
    
}

// MARK: UIPageViewControllerDataSource
extension ConfigurablePageViewController: ConfigurablePageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }

        return orderedViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }

        return orderedViewControllers[previousIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        
        return orderedViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = orderedViewControllers.index(of: firstViewController) else {
                return 0
        }
        return firstViewControllerIndex
    }
    
}

extension ConfigurablePageViewController: ConfigurablePageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        notifyConfigurableDelegateOfNewIndex()
    }
    
}

extension ConfigurablePageViewController: ConfigurablePageViewControllerScrollDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastXPos = scrollView.panGestureRecognizer.translation(in: scrollView.superview).x
        
        if (scrollView.panGestureRecognizer.velocity(in: scrollView.superview).x > 0) // show left side
        {
            startedToRightSide = false
            print("started to left")
        }
        else
        {
            startedToRightSide = true // show right side
            print("started to right")
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        lastXPos = 0
        startedToRightSide = false
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        lastXPos = 0
        startedToRightSide = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (scrollView.panGestureRecognizer.velocity(in: scrollView.superview).x > 0) // show left side
        {
            startedToRightSide = false
            print("going to left")
        }
        else
        {
            startedToRightSide = true // show right side
            print("going to right")
        }
        
        lastXPos = scrollView.panGestureRecognizer.translation(in: scrollView.superview).x

    }
}
