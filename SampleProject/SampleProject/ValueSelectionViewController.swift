//
//  ValueSelectionViewController.swift
//  SampleProject
//
//  Created by Pavan Kumar Valluru on 07.04.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import UIKit

protocol ValueSelectionTableDelegate: ConfigurableTableViewControllerTableDelegate {
    
}

protocol ValueSelectionTableDataSource: ConfigurableTableViewControllerTableDataSource {
    
}

class ValueSelectionViewController: ConfigurableTableViewController {
    
    // here there are not much details to implement a separate Model, so implementing them here
    var category = ValueSelectionCellViewModel.ValueSelectionCategory.Airline.rawValue
    var category_title = ""
    
    var delegate: ConfigurableTableViewControllerTableDelegate?
    
    // no seperate view model needed here as it is already embedded in cell view model
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.configureTableView()
        
        self.navigationController?.title = self.view_title.capitalized

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.tableView.indexPathForSelectedRow != nil {
            let cell = self.tableView.cellForRow(at: self.tableView.indexPathForSelectedRow!)
            self.delegate?.updateSelectedValue(for: category, newValue: (cell?.textLabel?.text!)!)
        }
        
    }
    
}

extension ValueSelectionViewController: ValueSelectionTableDataSource {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ValueSelectionCellViewModel(category: self.category).category_items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: ValueSelectionCellView!
                
        cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ValueSelectionCellView.self), for: indexPath) as? ValueSelectionCellView
        if cell == nil {
            cell = ValueSelectionCellView(style: UITableViewCellStyle.default, reuseIdentifier: String(describing: ValueSelectionCellView.self))
        }
        
        let cellModel = ValueSelectionCellViewModel(category: self.category)
        cellModel.title = cellModel.category_items[indexPath.row]
        
        cell.configure(withViewModel: cellModel)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.category_title
    }
    
}

extension ValueSelectionViewController: ValueSelectionTableDelegate {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        for i in 0..<tableView.numberOfRows(inSection: indexPath.section) {
            
            let path = IndexPath(row: i, section: indexPath.section)
            let cell = tableView.cellForRow(at: path)
            
            if (tableView.indexPathForSelectedRow != path) {
                
                cell?.accessoryView = nil
                cell?.accessoryType = .none
            }else {
                cell?.accessoryType = .checkmark
                (cell as! ValueSelectionCellView).saveSelectedIndex(index: i) // save the index
            }
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // overide protocol function from super view
    override func configureTableView() {
        
        super.configureTableView()
        
        self.tableView.allowsMultipleSelection = false
        self.tableView.allowsSelection = true
        
        self.tableView.register(ValueSelectionCellView.self, forCellReuseIdentifier: String(describing: ValueSelectionCellView.self))
    }

}
