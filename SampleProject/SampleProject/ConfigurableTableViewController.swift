//
//  ConfigurableTableViewController.swift
//  SampleProject
//
//  Created by Pavan Kumar Valluru on 07.04.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

protocol ConfigurableTableViewControllerTableDelegate: UITableViewDelegate {
    func configureTableView()
    func updateNewValue(for category: Int, newValue: String)
    func updateSelectedValue(for category: Int, newValue: String)
}

protocol ConfigurableTableViewControllerTableDataSource: UITableViewDataSource {
    
    var viewModel: ConfigurableTableViewModelProtocol { get set }
}

class ConfigurableTableViewController: UIViewController {
    
    var tableView: UITableView!
    
    var view_title = NSLocalizedString("Root View", comment: "")
    
    var _viewModel: ConfigurableTableViewModelProtocol = ConfigurableTableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.navigationController?.viewControllers[0] == self) {
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
            self.navigationItem.setRightBarButton(doneButton, animated: true)
        }
        
        //self.configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // apply title before showing
        self.title = view_title
    }
    
    func doneButtonTapped() {
        
        // if this viewcontroller is part of navigation controller and not root view controller then pop back
        if (self.navigationController != nil && self.navigationController!.viewControllers.count > 1) {
            self.navigationController?.popViewController(animated: true)
        } else { // if this viewcontroller is not part of navigation controller or is the root view controller, then dismiss
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func pushValueSelectionViewController(with category: Int, main_title: String, category_title: String) {
        let viewController = ValueSelectionViewController()
        viewController.category = category
        viewController.view_title = main_title
        viewController.category_title = category_title
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func pushValueEntryViewController(with category: Int, main_title: String, category_title: String) {
        let viewController = ValueEntryViewController()
        viewController.category = category
        viewController.view_title = main_title
        viewController.category_title = category_title
        viewController.initial_value = (self.tableView.cellForRow(at: self.tableView.indexPathForSelectedRow!) as? ConfigurableTableDetailCell)?.detailTextLabel?.text ?? ""
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension ConfigurableTableViewController: ConfigurableTableViewControllerTableDataSource {
    
    var viewModel: ConfigurableTableViewModelProtocol {
        get {
            return self._viewModel
        }
        set {
            self._viewModel = newValue
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
}

extension ConfigurableTableViewController: ConfigurableTableViewControllerTableDelegate {
    
    func updateNewValue(for category: Int, newValue: String) {
        // this is called after editing a value to immediately show on coming back
        print(newValue)
    }
    
    func updateSelectedValue(for category: Int, newValue: String) {
        // this will update the selected value from selection list
        print(newValue)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // to bring back to normal background from selected background
        tableView.deselectRow(at: indexPath, animated: true)
        
        //HINT: implement select actions here
    }
    
    // method implementation from protocol
    func configureTableView() {
        
        // setup tableview
        tableView = UITableView(frame: self.view.frame, style: UITableViewStyle.grouped)
        tableView.backgroundColor = AppConstants.Colors.TABLE_GRAY_BACKGROUND
        tableView.separatorStyle = .singleLine
        tableView.delegate = self
        tableView.dataSource = self
        tableView.alwaysBounceVertical = false
        tableView.isScrollEnabled = true
        tableView.tableHeaderView = nil
        tableView.tableFooterView = UIView() // to avoid separator lines if the cells are empty
        
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make -> Void in
            make.leading.equalTo(self.view.snp.leading)
            make.trailing.equalTo(self.view.snp.trailing)
            make.top.equalTo(self.view.snp.top)
            make.bottom.equalTo(self.view.snp.bottom)
        }
        
    }
    
}

