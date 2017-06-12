//
//  UserProfileViewController.swift
//  SampleProject
//
//  Created by Pavan Kumar Valluru on 10.04.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import  UIKit

protocol UserProfileTableViewDelegate: ConfigurableTableViewControllerTableDelegate {
    
}

protocol UserProfileViewTableDataSource: ConfigurableTableViewControllerTableDataSource {
    
}

extension UserProfileViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerView = self.tableView.tableHeaderView as! HeaderView
        headerView.scrollViewDidScroll(scrollView: scrollView)
    }

}

class UserProfileViewController: ConfigurableTableViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.viewModel = UserProfileTableViewModel()
        
        self.configureTableView()
        
        self.navigationController?.title = self.view_title
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewModel = UserProfileTableViewModel()
        self.tableView.reloadData()
    }
    
    override func doneButtonTapped() {
        super.doneButtonTapped()
    }
    
    // overide protocol function from super view
    override func configureTableView() {
        
        super.configureTableView()
        self.tableView.tableHeaderView = HeaderView.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 200))

        self.tableView.register(ConfigurableTableDetailCell.self, forCellReuseIdentifier: String(describing: ConfigurableTableDetailCell.self))
        self.tableView.register(ConfigurableTableButtonCell.self, forCellReuseIdentifier: String(describing: ConfigurableTableButtonCell.self))
        self.tableView.register(ConfigurableTableSwitchCell.self, forCellReuseIdentifier: String(describing: ConfigurableTableSwitchCell.self))
    }
    
}

extension UserProfileViewController: UserProfileTableViewDelegate {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell = tableView.cellForRow(at: indexPath) as? ConfigurableTableDetailCell
                pushValueEntryViewController(with: ConfigurableTableDetailCell.DetailCellCategory.FirstName.rawValue, main_title: "", category_title: cell?.textLabel?.text ?? "")
            case 1:
                let cell = tableView.cellForRow(at: indexPath) as? ConfigurableTableDetailCell
                pushValueEntryViewController(with: ConfigurableTableDetailCell.DetailCellCategory.DisplayName.rawValue, main_title: "", category_title: cell?.textLabel?.text ?? "")
            case 1:
                let cell = tableView.cellForRow(at: indexPath) as? ConfigurableTableDetailCell
                pushValueEntryViewController(with: ConfigurableTableDetailCell.DetailCellCategory.Email.rawValue, main_title: "", category_title: cell?.textLabel?.text ?? "")
            default:
                break
            }
        case 1:
            print("Section 1 clicked")
            break
        default:
            print("unknwon cell clicked or no action required")
        }
        
        // to bring back to normal background from selected background
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

extension UserProfileViewController: UserProfileViewTableDataSource {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.section_headers.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.rows_in_section[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString(viewModel.section_headers[section], comment: "")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: ConfigurableTableViewCell?
        
        var cellModel: ConfigurableTableViewCellViewModel!
        
        let cell_label_text: String? = self.viewModel.rows_in_section[indexPath.section][indexPath.row].name
        let cell_category: Int? = self.viewModel.rows_in_section[indexPath.section][indexPath.row].properties.category
        
        if (cell_label_text == nil || cell_category == nil) {
            fatalError("nil data not allowed")
        }
        
        switch self.viewModel.rows_in_section[indexPath.section][indexPath.row].properties.type {
            
        case CellType.ButtonCell.rawValue:
            cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ConfigurableTableButtonCell.self), for: indexPath) as? ConfigurableTableButtonCell
            if cell == nil {
                cell = ConfigurableTableButtonCell(style: UITableViewCellStyle.default, reuseIdentifier: String(describing: ConfigurableTableButtonCell.self))
            }
            cellModel = ConfigurableTableButtonCellViewModel(title: cell_label_text!, category: cell_category!)
            (cell as! ConfigurableTableButtonCell).configure(withViewModel: cellModel as! ConfigurableTableButtonCellViewModel)
            
        case CellType.DetailCell.rawValue:
            cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ConfigurableTableDetailCell.self), for: indexPath) as? ConfigurableTableDetailCell
            if cell == nil {
                cell = ConfigurableTableDetailCell(style: UITableViewCellStyle.value1, reuseIdentifier: String(describing: ConfigurableTableDetailCell.self))
            }
            cellModel = ConfigurableTableDetailCellViewModel(title: cell_label_text!, category: cell_category!)
            (cell as! ConfigurableTableDetailCell).configure(withViewModel: cellModel as! ConfigurableTableDetailCellViewModel)
            
        case CellType.SwitchCell.rawValue:
            cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ConfigurableTableSwitchCell.self), for: indexPath) as? ConfigurableTableSwitchCell
            if cell == nil {
                cell = ConfigurableTableSwitchCell(style: UITableViewCellStyle.default, reuseIdentifier: String(describing: ConfigurableTableSwitchCell.self))
            }
            cellModel = ConfigurableTableSwitchCellViewModel(title: cell_label_text!, category: cell_category!)
            (cell as! ConfigurableTableSwitchCell).configure(withViewModel: cellModel as! ConfigurableTableSwitchCellViewModel)
            
        case CellType.PictureInCell.rawValue:
            cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ConfigurableTablePictureInCell.self), for: indexPath) as? ConfigurableTablePictureInCell
            if cell == nil {
                cell = ConfigurableTablePictureInCell(style: UITableViewCellStyle.default, reuseIdentifier: String(describing: ConfigurableTablePictureInCell.self))
            }
            cellModel = ConfigurableTablePictureInCellViewModel(title: cell_label_text!, category: cell_category!)
            (cell as! ConfigurableTablePictureInCell).configure(withViewModel: cellModel as! ConfigurableTablePictureInCellViewModel)
            
        default:
            cell = ConfigurableTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: String(describing: ConfigurableTableViewCell.self))
            print("Settings view cell type not recognised!!")
            cell?.configure(withViewModel: cellModel)
        }
        
        return cell!
    }

}

extension UserProfileViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
    }
}
