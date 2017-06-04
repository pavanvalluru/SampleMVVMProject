//
//  ValueEntryViewController.swift
//  OffBlock3
//
//  Created by Pavan Kumar Valluru on 07.04.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

protocol ValueEntryTableDelegate: ConfigurableTableViewControllerTableDelegate {
    
}

protocol ValueEntryTableDataSource: ConfigurableTableViewControllerTableDataSource {
    
}

class ValueEntryViewController: ConfigurableTableViewController {
    
    let SUGGESTION_CELL_ID = "SuggestionsCell"
    
    // these are the values for Modal
    var category = ConfigurableTableDetailCell.DetailCellCategory.Empty.rawValue // this needs to be set before showing view controller
    var category_title = ""
    var initial_value = ""
    
    // to enable autofill suggestions
    var availableStrings: [String]?
    var suggestionsTableView: UITableView!
    var suggestions: [(name: String, detail: String)] = []
    
    var delegate: ConfigurableTableViewControllerTableDelegate?
        
    override func viewDidLoad() {
        
        super.viewDidLoad() // this would call configureTableView of this class instance from super class while it is overridden using protocol
        
        self.configureTableView()
        
        self.configureSuggestionsTableView()
        
        self.navigationController?.title = ""
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
        
        (self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ValueEntryTableViewCell)?.textField.text = initial_value
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.snp.remakeConstraints { (make) in
            make.leading.equalTo(self.view.snp.leading)
            make.trailing.equalTo(self.view.snp.trailing)
            make.top.equalTo(self.view.snp.top)
            make.height.equalTo(self.tableView.contentSize.height)
        }
        
        (self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ValueEntryTableViewCell)?.textField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let newText = (self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ValueEntryTableViewCell)?.textField.text ?? ""
        
        if initial_value == newText {
            return
        }
        
        switch category {
            
        case ConfigurableTableDetailCell.DetailCellCategory.FirstName.rawValue:
            UserDataManager.sharedInstance.firstName = newText
        case ConfigurableTableDetailCell.DetailCellCategory.LastName.rawValue:
            UserDataManager.sharedInstance.lastName = newText
        case ConfigurableTableDetailCell.DetailCellCategory.Email.rawValue:
            UserDataManager.sharedInstance.email = newText
        case ConfigurableTableDetailCell.DetailCellCategory.ConfigUpdateID.rawValue:
            UserDefaults.standard.set(newText, forKey: "id_value")
        case ConfigurableTableDetailCell.DetailCellCategory.ConfigUpdatePassword.rawValue:
            UserDefaults.standard.set(newText, forKey: "pin_value")
        case ConfigurableTableDetailCell.DetailCellCategory.Profession.rawValue:
            UserDefaults.standard.set(newText, forKey: "profession")
        case ConfigurableTableDetailCell.DetailCellCategory.Language.rawValue:
            break
        case ConfigurableTableDetailCell.DetailCellCategory.PushNotifications.rawValue:
            break
        case ConfigurableTableDetailCell.DetailCellCategory.AGB.rawValue:
            break
        case ConfigurableTableDetailCell.DetailCellCategory.Impressum.rawValue:
            break
        case ConfigurableTableDetailCell.DetailCellCategory.Privacy.rawValue:
            break
        case ConfigurableTableDetailCell.DetailCellCategory.OpenSource.rawValue:
            break
        default:
            break
        }
        
        self.delegate?.updateNewValue(for: category, newValue: newText)
    }
    
    // setup auto fill tableview
    func configureSuggestionsTableView() {
        
        suggestionsTableView = UITableView(frame: self.view.frame, style: UITableViewStyle.grouped)
        suggestionsTableView.backgroundColor = AppConstants.Colors.TABLE_GRAY_BACKGROUND
        suggestionsTableView.separatorStyle = .singleLine
        suggestionsTableView.delegate = self
        suggestionsTableView.dataSource = self
        suggestionsTableView.alwaysBounceVertical = false
        suggestionsTableView.isScrollEnabled = true
        suggestionsTableView.tableHeaderView = UIView(frame: CGRect(x: 0,y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
        suggestionsTableView.tableFooterView = UIView()
        suggestionsTableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.interactive
        
        suggestionsTableView.sectionHeaderHeight = 0
        self.suggestionsTableView.rowHeight = 44
        
        self.view.addSubview(suggestionsTableView)
        suggestionsTableView.snp.makeConstraints { make -> Void in
            make.leading.equalTo(self.view.snp.leading)
            make.trailing.equalTo(self.view.snp.trailing)
            make.top.equalTo(self.tableView.snp.bottom)
            make.bottom.equalTo(self.view.snp.bottom)
        }
    }
    
}

extension ValueEntryViewController: ValueEntryTableDataSource {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // for both tableviews there is only 1 section
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.tableView {
            return 1
        } else if tableView == suggestionsTableView {
            return suggestions.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.tableView {
            var cell: ValueEntryTableViewCell!
            
            cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ValueEntryTableViewCell.self), for: indexPath) as? ValueEntryTableViewCell
            if cell == nil {
                cell = ValueEntryTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: String(describing: ValueEntryTableViewCell.self))
            }
            
            cell?.preservesSuperviewLayoutMargins = false
            cell?.separatorInset = UIEdgeInsets.zero
            cell?.layoutMargins = UIEdgeInsets.zero
            
            let cellModel = ValueEntryTableViewCellViewModel(title: self.category_title, category: category)
            
            cell.configure(withViewModel: cellModel)
            cell.textField.text = initial_value
            cell.textField.returnKeyType = .done
            cell.textField.delegate = self
            
            if cell.category == ConfigurableTableDetailCell.DetailCellCategory.Password.rawValue {
                cell.textField.isSecureTextEntry = true
            }
            
            return cell
            
        } else if tableView == self.suggestionsTableView {
            
            var cell: UITableViewCell!
            
            cell = tableView.dequeueReusableCell(withIdentifier: SUGGESTION_CELL_ID)
            if cell == nil {
                cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: SUGGESTION_CELL_ID)
                cell.accessoryType = .none
                cell.textLabel?.font = AppConstants.Fonts.SF_UIText_Regular_17
                cell.textLabel?.textColor = UIColor.black
                
                cell.detailTextLabel?.textColor = AppConstants.Colors.MYAPP_DETAIL_TEXT_GRAY
                cell.detailTextLabel?.font = AppConstants.Fonts.SF_UIText_Regular_13
            }
            cell.textLabel?.text = suggestions[indexPath.row].name.uppercased()
            cell.detailTextLabel?.text = suggestions[indexPath.row].detail
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.separatorInset = UIEdgeInsetsMake(0, 16, 0, 0)
    }

}

extension ValueEntryViewController: ValueEntryTableDelegate {
    
    // overide protocol function from super view
    override func configureTableView() {
        
        super.configureTableView()
        
        self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
        self.tableView.sectionFooterHeight = 0
        self.tableView.sectionHeaderHeight = 0
        
        self.tableView.register(ValueEntryTableViewCell.self, forCellReuseIdentifier: String(describing: ValueEntryTableViewCell.self))
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView == self.tableView {
            if let cell = tableView.cellForRow(at: indexPath) as? ValueEntryTableViewCell {
                cell.textField.becomeFirstResponder()
            }
        }else if tableView == suggestionsTableView {
            let cell1 = (self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ValueEntryTableViewCell)
            
            if cell1!.textField.isFirstResponder {
                cell1?.textField.text = suggestions[indexPath.row].name
            }
        }
        
    }
    
}

extension ValueEntryViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        let newText = (textField.text as String?)
        
        if availableStrings != nil {
            let filteredList = availableStrings!.filter { $0.hasPrefix(newText!) }
            
            suggestions.removeAll()
            
            for i in 0..<filteredList.count {
                suggestions.insert((name: filteredList[i], detail: ""), at: i)
            }
            
            suggestionsTableView.reloadData()
        }

        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.doneButtonTapped()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // text hasn't changed yet, we have to compute the text AFTER the edit ourself
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        
        if availableStrings != nil {
            let filteredList = availableStrings!.filter { $0.hasPrefix(newText!) }
            
            suggestions.removeAll()
            
            for i in 0..<filteredList.count {
                suggestions.insert((name: filteredList[i], detail: ""), at: i)
            }
            
            suggestionsTableView.reloadData()
        }
        
        return true
    }

}
