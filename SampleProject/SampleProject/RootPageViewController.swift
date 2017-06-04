//
//  RootPageViewController.swift
//  Center3
//
//  Created by Pavan Kumar Valluru on 13.04.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import UIKit

class RootPageViewController: ConfigurablePageViewController {
    
    let LEFT_IMAGE = "Profile"
    let LEFT_IMAGE_ACTIVE = "ProfileActive"
    
    let RIGHT_IMAGE = "Menu"
    let RIGHT_IMAGE_ACTIVE = "MenuActive"
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var centerButton: UIButton!
    var leftBarButton: UIButton!
    var rightBarButton: UIButton!
    var leftButtonItem: UIBarButtonItem!
    var rightButtonItem: UIBarButtonItem!
    
    var highlightBorderLayer = CALayer()
    
    override func viewDidLoad() {
        
        self.orderedViewControllers = [UserProfileViewController(),CenterViewController(),ConfigUpdateViewController()]
        
        super.viewDidLoad()
        
        self.pageViewDelegate = self
        
        setupNavigationBarButtons()
        
        // show center page at the start
        centerButtonClicked()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.highlightBorderLayer.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.highlightBorderLayer.isHidden = true
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        
        if (fromInterfaceOrientation == UIInterfaceOrientation.portrait) {
            self.scrollView.isScrollEnabled = false // disable scroll
        }
        else {
            self.scrollView.isScrollEnabled = true
        }
        self.updateWithIndex(index: self.currentIndex)

    }
    
    func getCenterButton(withImage: String = "", title: String = NSLocalizedString("My Friends", comment: "")) -> UIButton {
        
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 70, height: 44)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        button.titleLabel?.font = AppConstants.Fonts.SF_UIText_SemiBold_16
        button.setTitleColor(AppConstants.Colors.MYAPP_TEXT_BLUE, for: .normal)
        button.setTitle(title, for: .normal)
        button.setImage(UIImage(named: withImage), for: .normal)
        button.sizeThatFits(button.intrinsicContentSize)
        
        return button
    }
    
    func setupCenterButton() {
        
        centerButton = getCenterButton()
        centerButton.adjustsImageWhenHighlighted = false
        centerButton.addTarget(self, action: #selector(centerButtonClicked), for: .touchUpInside)
        navigationItem.titleView = centerButton
      
    }
    
    func setupNavigationBarButtons() {
        
        setupCenterButton()
        
        leftBarButton = UIButton(type: .custom)
        leftBarButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        leftBarButton.imageView?.contentMode = .scaleAspectFit
        leftBarButton.addTarget(self, action: #selector(leftButtonClicked), for: .touchUpInside)
        leftBarButton.setImage(UIImage(named: self.LEFT_IMAGE), for: .normal)
        
        rightBarButton = UIButton(type: .custom)
        rightBarButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        rightBarButton.imageView?.contentMode = .scaleAspectFit
        rightBarButton.addTarget(self, action: #selector(rightButtonClicked), for: .touchUpInside)
        rightBarButton.setImage(UIImage(named: self.RIGHT_IMAGE), for: .normal)
        
        leftButtonItem = UIBarButtonItem(customView: leftBarButton)
        rightButtonItem = UIBarButtonItem(customView: rightBarButton)
        
        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -16
        
        self.navigationItem.setLeftBarButtonItems([negativeSpacer,leftButtonItem], animated: true)
        self.navigationItem.setRightBarButtonItems([negativeSpacer,rightButtonItem], animated: true)
    }
    
    func leftButtonClicked() {
        self.scrollToViewController(index: 0)
        setLeftActiveIcon()
    }
    
    func rightButtonClicked() {
        self.scrollToViewController(index: 2)
        setRightActiveIcon()
    }
    
    func centerButtonClicked() {
        self.scrollToViewController(index: 1)
        resetToolBarImages()
    }
    
    func updateWithIndex(index: Int) {
        if(index == 0) {
            setLeftActiveIcon()
        }else if index == 2 {
            setRightActiveIcon()
        }else {
            resetToolBarImages()
        }
    }
    
    func resetToolBarImages() {
        
        UIView.animate(withDuration: 0.25, animations: {
            self.leftBarButton.setImage(UIImage(named: self.LEFT_IMAGE), for: .normal)
            self.rightBarButton.setImage(UIImage(named: self.RIGHT_IMAGE), for: .normal)
            self.centerButton.setTitleColor(AppConstants.Colors.MYAPP_TEXT_BLUE, for: .normal)
            self.centerButton.setImage(UIImage(named: ""), for: .normal)
            self.centerButton.drawBottomBorderWithLayer(borderLayer: self.highlightBorderLayer, color: AppConstants.Colors.MYAPP_TEXT_BLUE, borderHeight: 1.0)
        })
        
    }
    
    func setRightActiveIcon() {
        
        UIView.animate(withDuration: 0.25, animations: {
            self.leftBarButton.setImage(UIImage(named: self.LEFT_IMAGE), for: .normal)
            self.rightBarButton.setImage(UIImage(named: self.RIGHT_IMAGE_ACTIVE), for: .normal)
            self.centerButton.setTitleColor(AppConstants.Colors.TOOL_BAR_TEXT_COLOR, for: .normal)
            self.centerButton.setImage(UIImage(named: ""), for: .normal)
            self.rightButtonItem.customView?.drawBottomBorderWithLayer(borderLayer: self.highlightBorderLayer, color: AppConstants.Colors.MYAPP_TEXT_BLUE, borderHeight: 1.0)
        })
        
    }
    
    func setLeftActiveIcon() {
        
        UIView.animate(withDuration: 0.25, animations: {
            self.leftBarButton.setImage(UIImage(named: self.LEFT_IMAGE_ACTIVE), for: .normal)
            self.rightBarButton.setImage(UIImage(named: self.RIGHT_IMAGE), for: .normal)
            self.centerButton.setTitleColor(AppConstants.Colors.TOOL_BAR_TEXT_COLOR, for: .normal)
            self.centerButton.setImage(UIImage(named: ""), for: .normal)
            self.leftButtonItem.customView?.drawBottomBorderWithLayer(borderLayer: self.highlightBorderLayer, color: AppConstants.Colors.MYAPP_TEXT_BLUE, borderHeight: 1.0)
        })
        
    }
    
}

extension RootPageViewController {
    
    override func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        
        return -1 // to hide page control
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        var multiplier = scrollView.contentOffset.x/scrollView.bounds.size.width
        // return if no change needed
        if multiplier == 0 {
            return
        }
        
        // determine direction of drag
        let velocity = scrollView.panGestureRecognizer.velocity(in: scrollView.superview).x
        if (velocity > 0) {
            startedToRightSide = false
        }
        else {
            startedToRightSide = true // show right side
        }
        
        // get current layer border position and width
        let current_width = self.highlightBorderLayer.frame.width
        let current_posX = self.highlightBorderLayer.frame.origin.x
        
        // initialise target position and width
        var target_width = current_width
        var target_posX = current_posX
        
        // determine target position and width based on current page index and direction of drag
        switch self.currentIndex {
        case 0:
            if (startedToRightSide && multiplier > 1.0) { // multiplier > 1.5 -> to move layer only after half page transition/drag
                multiplier = multiplier-1
                target_posX = centerButton.frame.origin.x
                target_width = centerButton.frame.width
            }else {
                target_posX = leftButtonItem.customView!.frame.origin.x
                target_width = leftButtonItem.customView!.frame.width
            }
        case 1:
            if (startedToRightSide && multiplier > 1.0) { // multiplier > 1.5 -> to move layer only after half page transition/drag
                multiplier = multiplier-1
                target_posX = rightButtonItem.customView!.frame.origin.x
                target_width = rightButtonItem.customView!.frame.width
            }else if !startedToRightSide && multiplier < 1.0 && multiplier > 0 { // multiplier < 0.5 -> to move layer only after half page transition/drag
                multiplier = 1-multiplier
                target_posX = leftButtonItem.customView!.frame.origin.x
                target_width = leftButtonItem.customView!.frame.width
            } else {
                target_posX = centerButton.frame.origin.x
                target_width = centerButton.frame.width
            }
        case 2:
            if (startedToRightSide && multiplier > 1.0 && multiplier < 1) { // multiplier > 0.5 -> to move layer only after half page transition/drag
                target_posX = rightButtonItem.customView!.frame.origin.x
                target_width = rightButtonItem.customView!.frame.width
            } else if !startedToRightSide && multiplier < 1.0 && multiplier > 0 { // multiplier < 0.5 -> to move layer only after half page transition/drag
                multiplier = 1-multiplier
                target_posX = centerButton.frame.origin.x
                target_width = centerButton.frame.width
            } else {
                target_posX = rightButtonItem.customView!.frame.origin.x
                target_width = rightButtonItem.customView!.frame.width
            }
        default:
            print ("page index invalid")
            return
        }
        
        multiplier = multiplier/12 // to reduce speed of movement otherwise layer moves far ahead of page
        
        // calculate proportion value to be added to current value
        let addWidth = (target_width-current_width)*multiplier
        let addPosX = (target_posX-current_posX)*multiplier
        
        // update border layer frame with new values
        let frame = self.highlightBorderLayer.frame
        self.highlightBorderLayer.frame = CGRect(x: current_posX+addPosX, y: frame.origin.y, width: current_width+addWidth, height: frame.height)
    }

}

extension RootPageViewController: ConfigurablePageViewControllerCustomProtocol {
    
    func configurablePageViewController(_ configurablePageViewController: ConfigurablePageViewController, didUpdatePageCount count: Int) {
        
        print("updated count")
    }
    
    func configurablePageViewController(_ configurablePageViewController: ConfigurablePageViewController, didUpdatePageIndex index: Int) {
        
        print("updated page: \(index)")
        self.updateWithIndex(index: index)
    }
}
