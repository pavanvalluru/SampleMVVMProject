//
//  ConfigUpdateViewController.swift
//  OffBlock3
//
//  Created by Pavan Kumar Valluru on 02.05.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import UIKit

protocol ConfigUpdateTableViewDelegate: ConfigurableTableViewControllerTableDelegate {
    
}

protocol ConfigUpdateTableDataSource: ConfigurableTableViewControllerTableDataSource {
    
}

class ConfigUpdateViewController: ConfigurableTableViewController {
    
    let ID = 0
    let PIN = 1
    let OTP = 2
    let SECURE_ID = 3
    
    var companyName: String = ""
    var secure_token: String = ""
    var otp: String = ""
    
    var startMonth: Int = Date().previousMonth.currentMonthIndex
    var endMonth: Int = Date().nextMonth.currentMonthIndex
    
    var startYear: Int = Date().previousMonth.currentYear
    var endYear: Int = Date().nextMonth.currentYear
    
    var parameters: [String: String] = [:]
    
    lazy var durationPicker: MonthYearDatePicker = MonthYearDatePicker()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.viewModel = ConfigUpdateTableViewModel()
        
        self.configureTableView()
        self.tableView.estimatedSectionHeaderHeight = 41
        self.tableView.sectionFooterHeight = 0.01
        
        self.navigationController?.title = self.view_title
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserDataManager.sharedInstance.userDefaults.integer(forKey: "currentIndex") == 0 { // no index selected, so no options possible
            self.tableView.tableFooterView = nil
        } else {
            setupUpdateStartButton()
        }
        
        self.tableView.reloadData()
    }
    
    override func configureTableView() {
        super.configureTableView()
        
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.register(ConfigurableTableDetailCell.self, forCellReuseIdentifier: String(describing: ConfigurableTableDetailCell.self))
        self.tableView.register(ConfigurableTableSwitchCell.self, forCellReuseIdentifier: String(describing: ConfigurableTableSwitchCell.self))
        self.tableView.register(ConfigurableTableButtonCell.self, forCellReuseIdentifier: String(describing: ConfigurableTableButtonCell.self))
        self.tableView.register(ConfigUpdateStartEndTimeCell.self, forCellReuseIdentifier: String(describing: ConfigUpdateStartEndTimeCell.self))
    }
    
    func setupUpdateStartButton() {
        
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 78))
        let deleteButton = UIButton()
        deleteButton.layer.cornerRadius = 5
        deleteButton.backgroundColor = AppConstants.Colors.MYAPP_TEXT_BLUE
        deleteButton.titleLabel?.font = AppConstants.Fonts.SF_UIText_Medium_16
        deleteButton.setTitleColor(UIColor.white, for: .normal)
        deleteButton.setTitle(NSLocalizedString("Update starten", comment: ""), for: .normal)
        deleteButton.addTarget(self, action: #selector(triggerConfigUpdate), for: .touchUpInside)
        footer.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { (make) in
            make.leading.equalTo(footer.snp.leading).offset(73)
            make.trailing.equalTo(footer.snp.trailing).offset(-73)
            make.height.equalTo(30)
            make.top.equalTo(footer.snp.top).offset(24)
        }
        self.tableView.tableFooterView = footer

    }
    
    func triggerConfigUpdate() {
        
        if companyName.characters.count <= 1 {
            
            // create the alert
            let alert = UIAlertController(title: "SampleProject", message: NSLocalizedString("Bitte eine Option auswählen zum fortfahren", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
            
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertActionStyle.default, handler: { action in
                self.pushValueSelectionViewController(with: ValueSelectionCellViewModel.ValueSelectionCategory.Airline.rawValue, main_title: "", category_title: "ConfigType")
            }))
            alert.addAction(UIAlertAction(title: NSLocalizedString("Abbrechen", comment: ""), style: UIAlertActionStyle.cancel, handler: { action in
                
            }))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            if (viewModel as! ConfigUpdateTableViewModel).allowsTimePeriodSelection && UserDataManager.sharedInstance.userDefaults.integer(forKey: "duration_type") == 1 {
                
                // do any additional things needed here
                
            } else {
                
                let curMonth = UserDefaults.standard.bool(forKey: "current_month")
                let prevMonth = UserDefaults.standard.bool(forKey: "previous_month")
                let nextMonth = UserDefaults.standard.bool(forKey: "next_month")
                
                if prevMonth {
                    startYear = Date().previousMonth.currentYear
                    startMonth = Date().previousMonth.currentMonthIndex
                } else if curMonth {
                    startYear = Date().currentYear
                    startMonth = Date().currentMonthIndex
                } else if nextMonth {
                    startYear = Date().nextMonth.currentYear
                    startMonth = Date().nextMonth.currentMonthIndex
                }
                
                if nextMonth {
                    endYear = Date().nextMonth.currentYear
                    endMonth = Date().nextMonth.currentMonthIndex
                } else if curMonth {
                    endYear = Date().currentYear
                    endMonth = Date().currentMonthIndex
                } else if prevMonth {
                    endYear = Date().previousMonth.currentYear
                    endMonth = Date().previousMonth.currentMonthIndex
                }
                
                if prevMonth && !curMonth && nextMonth {
                    // TODO handle this case - currently it will fetch also current month
                    
                } else if !prevMonth && !curMonth && !nextMonth {
                    // create the alert
                    let alert = UIAlertController(title: "SampleProject", message: NSLocalizedString("Bitte einen Monat auswählen", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
                    // add the actions (buttons)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertActionStyle.default, handler: { action in
                        
                    }))
                    alert.addAction(UIAlertAction(title: NSLocalizedString("Abbrechen", comment: ""), style: UIAlertActionStyle.cancel, handler: { action in
                        
                    }))
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                    return
                }
            }
            
        }
        
        if (viewModel as! ConfigUpdateTableViewModel).needsSecureToken {
            self.showAlertControllerForToken()
            
        } else {
            self.startUpdateNow(with: parameters)
        }

    }
    
    func handleViewOnFailure() {
        
        if self.navigationController?.presentedViewController != nil {
            self.navigationController?.presentedViewController?.dismiss(animated: true, completion: nil)
        }else {
            self.doneButtonTapped()
        }
    }
    
    func startUpdateNow(with parameters: [String: String]) {

    }
    
    func getSegmentedControl(with items: [String], tag: Int) -> UISegmentedControl {
        
        let mySegmentedControl = UISegmentedControl (items: items)
        
        mySegmentedControl.tag = tag
        //Change text color of UISegmentedControl
        mySegmentedControl.tintColor = AppConstants.Colors.MYAPP_TEXT_BLUE
        //Change UISegmentedControl background colour
        mySegmentedControl.backgroundColor = UIColor.clear
        // Add function to handle Value Changed events
        mySegmentedControl.addTarget(self, action: #selector(segmentedValueChanged(sender:)), for: .valueChanged)
        
        return mySegmentedControl
    }
    
    func dateFromIndexes(month: Int, year: Int) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM yyyy"
        
        return dateFormatter.date(from: "\(month) \(year)")!
    }
    
    func setupMonthPicker(for indexPath: IndexPath) { // this will automatically setup start and end values
        let mainCell = tableView.cellForRow(at: indexPath) as? ConfigUpdateStartEndTimeCell
        
        guard mainCell != nil else {
            return
        }
        
        if mainCell!.startValueLabel.textColor == AppConstants.Colors.MYAPP_TEXT_BLUE {
            durationPicker.month = self.startMonth
            durationPicker.year = self.startYear
            durationPicker.onDateSelected = { (month: Int, year: Int) in
                self.startYear = year
                self.startMonth = month
                 mainCell!.startValueLabel.text = "\(DateFormatter().monthSymbols[month-1].capitalized) \(year)" // because the array index starts with 0, 1 should be deducted
                
            }
        }else {
            durationPicker.month = self.endMonth
            durationPicker.year = self.endYear
            durationPicker.onDateSelected = { (month: Int, year: Int) in
                self.endYear = year
                self.endMonth = month
                mainCell!.endValuelabel.text = "\(DateFormatter().monthSymbols[month-1].capitalized) \(year)"
            }
        }
    }
    
    func showAlertControllerForToken() {
        
        let alertController = UIAlertController(title: NSLocalizedString("Bitte ausfüllen", comment: ""), message: "", preferredStyle:
            UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Jetzt starten", comment: ""), style: .default, handler:
            {
                action in
                
                let id = (alertController.textFields?.filter{$0.tag == self.ID})?[0].text
                if id != nil && id!.characters.count > 0 {
                    print(id!)
                }
                
                if (alertController.textFields?.filter{$0.tag == self.PIN})!.count > 0 {
                    let password = (alertController.textFields?.filter{$0.tag == self.PIN})?[0].text
                    print(password!)
                }
                
                if (alertController.textFields?.filter{$0.tag == self.SECURE_ID})!.count > 0 {
                    let secure_token = (alertController.textFields?.filter{$0.tag == self.SECURE_ID})?[0].text
                    print(secure_token ?? "")
                }
                
                if (alertController.textFields?.filter{$0.tag == self.OTP})!.count > 0 {
                    let otp = (alertController.textFields?.filter{$0.tag == self.OTP})?[0].text
                    print(otp ?? "")
                }
                
                self.startUpdateNow(with: self.parameters)
        }))
        
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Abbrechen", comment: ""), style: .cancel, handler: nil))
        
        alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            let crewIdName = (self.viewModel as! ConfigUpdateTableViewModel).latest_rows_in_section()[1].last?.name ?? "Id"
            textField.tag = self.ID
            textField.placeholder = NSLocalizedString(crewIdName, comment: "")
            textField.clearButtonMode = .whileEditing
            textField.textColor = AppConstants.Colors.MYAPP_TEXT_BLACK
            textField.tintColor = AppConstants.Colors.MYAPP_TEXT_BLACK
            textField.text = ""
        })
        
        alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            let pwd_title = (self.viewModel as! ConfigUpdateTableViewModel).latest_rows_in_section()[1][1].name
            textField.tag = self.PIN
            textField.placeholder = NSLocalizedString(pwd_title, comment: "")
            textField.isSecureTextEntry = true
            textField.clearButtonMode = .whileEditing
            textField.textColor = AppConstants.Colors.MYAPP_TEXT_BLACK
            textField.tintColor = AppConstants.Colors.MYAPP_TEXT_BLACK
            textField.text = ""
        })
        
        if (self.viewModel as! ConfigUpdateTableViewModel).needsSecureToken && UserDataManager.sharedInstance.userDefaults.integer(forKey: "password_type") == 0 {

            alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
                textField.tag = self.SECURE_ID
                textField.placeholder = NSLocalizedString("Secure-ID Number", comment: "")
                textField.isSecureTextEntry = true
                textField.clearButtonMode = .whileEditing
                textField.textColor = AppConstants.Colors.MYAPP_TEXT_BLACK
                textField.tintColor = AppConstants.Colors.MYAPP_TEXT_BLACK
                textField.text = ""
                textField.keyboardType = .numberPad
                textField.becomeFirstResponder()
            })
            
        }else {
            
            if (self.viewModel as! ConfigUpdateTableViewModel).needsSecureToken && UserDataManager.sharedInstance.userDefaults.integer(forKey: "password_type") == 1 {
                alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
                    textField.tag = self.OTP
                    textField.placeholder = NSLocalizedString("Einmal Passwort", comment: "")
                    textField.isSecureTextEntry = true
                    textField.clearButtonMode = .whileEditing
                    textField.textColor = AppConstants.Colors.MYAPP_TEXT_BLACK
                    textField.tintColor = AppConstants.Colors.MYAPP_TEXT_BLACK
                    textField.text = ""
                    textField.becomeFirstResponder()
                })
            }
        }
        
        self.present(alertController, animated: true, completion: nil)

    }

}

extension ConfigUpdateViewController: ConfigUpdateTableViewDelegate {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let isDurationCell = tableView.cellForRow(at: indexPath)?.isKind(of: ConfigUpdateStartEndTimeCell.self) ?? false
        if isDurationCell && UserDataManager.sharedInstance.userDefaults.integer(forKey: "duration_type") == 1 {
            if (viewModel as! ConfigUpdateTableViewModel).showsTimePicker {
                // not needed to do any thing here
            } else {
                (viewModel as! ConfigUpdateTableViewModel).showsTimePicker = true
                tableView.insertRows(at: [IndexPath(row: indexPath.row+1, section: indexPath.section)], with: .automatic)
            }
            setupMonthPicker(for: indexPath)
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell = tableView.cellForRow(at: indexPath) as? ConfigurableTableDetailCell
                pushValueSelectionViewController(with: ValueSelectionCellViewModel.ValueSelectionCategory.Airline.rawValue, main_title: "", category_title: cell?.textLabel?.text ?? "")
                
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 1:
                let cell = tableView.cellForRow(at: indexPath) as? ConfigurableTableDetailCell
                pushValueEntryViewController(with: ConfigurableTableDetailCell.DetailCellCategory.ConfigUpdatePassword.rawValue, main_title: "", category_title: cell?.textLabel?.text ?? "")
                
            case 2: 
                let cell = tableView.cellForRow(at: indexPath) as? ConfigurableTableDetailCell
                pushValueEntryViewController(with: ConfigurableTableDetailCell.DetailCellCategory.ConfigUpdateID.rawValue, main_title: "", category_title: cell?.textLabel?.text ?? "")
                
            default:
                break
            }
        case 2:
            break
        
        default:
            print("unknwon cell clicked or no action required")
        }
        
        // to bring back to normal background from selected background
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension ConfigUpdateViewController: ConfigUpdateTableDataSource {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.section_headers.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 1 && !UserDefaults.standard.bool(forKey: "update_pin") {
            return 2
        }
        
        return (viewModel as! ConfigUpdateTableViewModel).latest_rows_in_section()[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 1 && (viewModel as! ConfigUpdateTableViewModel).needsSecureToken) || (section == 2 && (viewModel as! ConfigUpdateTableViewModel).allowsTimePeriodSelection) {
            return ""
        }
        
        if (viewModel as! ConfigUpdateTableViewModel).latest_rows_in_section()[section].count == 0 {
            return ""
        }
        
        return NSLocalizedString(viewModel.section_headers[section], comment: "")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    // header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UITableViewHeaderFooterView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 41))
        
        if section == 1 && (viewModel as! ConfigUpdateTableViewModel).needsSecureToken {
            let seg_view = getSegmentedControl(with: [NSLocalizedString("Secure Token", comment: ""),NSLocalizedString("Einmal Passwort", comment: "")], tag: section)
            
            if section == 1 {
                seg_view.selectedSegmentIndex = UserDataManager.sharedInstance.userDefaults.integer(forKey: "password_type")
            }
            
            view.contentView.addSubview(seg_view)
            seg_view.snp.makeConstraints { (make) in
                make.center.equalTo(view.contentView.snp.center)
                make.top.equalTo(view.contentView.snp.top).offset(6)
                make.bottom.equalTo(view.contentView.snp.bottom).offset(-6)
                make.height.equalTo(29)
            }
            
        }else if section == 2 && (viewModel as! ConfigUpdateTableViewModel).allowsTimePeriodSelection {
            view.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 127)
            
            let title_label = UILabel()
            title_label.font = AppConstants.Fonts.SF_UIText_Regular_13
            title_label.textColor = AppConstants.Colors.TOOL_BAR_TEXT_COLOR
            title_label.text = NSLocalizedString(viewModel.section_headers[section], comment: "").uppercased()
            view.contentView.addSubview(title_label)
            title_label.snp.makeConstraints { (make) in
                make.leading.equalTo(view.contentView.snp.leading).offset(16)
                make.top.equalTo(view.contentView.snp.top).offset(19)
                make.height.equalTo(18)
            }
            
            let seg_view = getSegmentedControl(with: [NSLocalizedString("Einzelne Monat", comment: ""),NSLocalizedString("Zeitraum", comment: "")], tag: section)
            
            if section == 2 {
                seg_view.selectedSegmentIndex = UserDataManager.sharedInstance.userDefaults.integer(forKey: "duration_type")
            }
            
            view.contentView.addSubview(seg_view)
            seg_view.snp.makeConstraints { (make) in
                make.top.equalTo(view.contentView.snp.top).offset(47)
                make.centerX.equalTo(view.contentView.snp.centerX)
                make.bottom.equalTo(view.contentView.snp.bottom).offset(-53)
                make.height.equalTo(29)
            }
            
            let info_label = UILabel()
            info_label.numberOfLines = 2
            info_label.font = AppConstants.Fonts.SF_UIText_Regular_13
            info_label.textColor = AppConstants.Colors.TOOL_BAR_TEXT_COLOR
            info_label.text = NSLocalizedString("You may choose either durartion or specific months.", comment: "")
            view.contentView.addSubview(info_label)
            info_label.snp.makeConstraints { (make) in
                make.leading.equalTo(view.contentView.snp.leading).offset(16)
                make.trailing.equalTo(view.contentView.snp.trailing).offset(-19)
                make.bottom.equalTo(view.contentView.snp.bottom).offset(-4)
            }

        }else {
            view.textLabel?.text = NSLocalizedString(viewModel.section_headers[section], comment: "")
        }
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: ConfigurableTableViewCell?
        
        var cellModel: ConfigurableTableViewCellViewModel!
        
        let cell_label_text: String? = (viewModel as! ConfigUpdateTableViewModel).latest_rows_in_section()[indexPath.section][indexPath.row].name
        let cell_category: Int? = (viewModel as! ConfigUpdateTableViewModel).latest_rows_in_section()[indexPath.section][indexPath.row].properties.category
        
        if (cell_label_text == nil || cell_category == nil) {
            fatalError("nil data not allowed")
        }
        
        switch (self.viewModel as! ConfigUpdateTableViewModel).latest_rows_in_section()[indexPath.section][indexPath.row].properties.type {
            
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
            if indexPath.row == 0 && indexPath.section == 0 {
                companyName = ValueSelectionCellViewModel(category: cell_category!).category_items[(self.viewModel as! ConfigUpdateTableViewModel).configIndex]
                (cellModel as! ConfigurableTableDetailCellViewModel).detailText = companyName
            } else if (indexPath.row == 1 && indexPath.section == 1 && !UserDefaults.standard.bool(forKey: "update_pin")) {
                cellModel = ConfigurableTableDetailCellViewModel(title: (viewModel as! ConfigUpdateTableViewModel).latest_rows_in_section()[indexPath.section][indexPath.row+1].name, category: (viewModel as! ConfigUpdateTableViewModel).latest_rows_in_section()[indexPath.section][indexPath.row+1].properties.category)
            }
            (cell as! ConfigurableTableDetailCell).configure(withViewModel: cellModel as! ConfigurableTableDetailCellViewModel)
            
        case CellType.SwitchCell.rawValue:
            cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ConfigurableTableSwitchCell.self), for: indexPath) as? ConfigurableTableSwitchCell
            if cell == nil {
                cell = ConfigurableTableSwitchCell(style: UITableViewCellStyle.default, reuseIdentifier: String(describing: ConfigurableTableSwitchCell.self))
            }
            cellModel = ConfigurableTableSwitchCellViewModel(title: cell_label_text!, category: cell_category!)
            (cell as! ConfigurableTableSwitchCell).configure(withViewModel: cellModel as! ConfigurableTableSwitchCellViewModel)
            if indexPath.section == 1 && indexPath.row == 0 {
                (cell as! ConfigurableTableSwitchCell).switchToggle.addTarget(self, action: #selector(onSwitchToggle(sender:)), for: .valueChanged)
            }
            
        case CellType.ConfigUpdateStartEndTimeCell.rawValue:
            if cell_category == 0 {
                cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ConfigUpdateStartEndTimeCell.self), for: indexPath) as? ConfigUpdateStartEndTimeCell
                if cell == nil {
                    cell = ConfigUpdateStartEndTimeCell(style: UITableViewCellStyle.value1, reuseIdentifier: String(describing: ConfigUpdateStartEndTimeCell.self))
                }
                (cell as! ConfigUpdateStartEndTimeCell).configure(startTime: dateFromIndexes(month: startMonth, year: startYear), endTime: dateFromIndexes(month: endMonth, year: endYear))
                
            } else if cell_category == 1 {
                let cell = UITableViewCell()
                setupMonthPicker(for: IndexPath(row: indexPath.row-1, section: indexPath.section))
                
                cell.contentView.addSubview(durationPicker)
                durationPicker.snp.makeConstraints { (make) in
                    make.leading.equalTo(cell.contentView.snp.leading)
                    make.trailing.equalTo(cell.contentView.snp.trailing)
                    make.top.equalTo(cell.contentView.snp.top)
                    make.height.equalTo(221)
                    make.bottom.equalTo(cell.contentView.snp.bottom)
                }
                return cell
            }
            
        default:
            cell = ConfigurableTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: String(describing: ConfigurableTableViewCell.self))
            print("Settings view cell type not recognised!!")
            cell?.configure(withViewModel: cellModel)
        }
        
        return cell!
    }
    
}

extension ConfigUpdateViewController {
    
    func onSwitchToggle(sender: UISwitch) {
        
        if sender.isOn {
            self.tableView.insertRows(at: [IndexPath(row: 1, section: 1)], with: .automatic)
        } else if tableView.numberOfRows(inSection: 1) > 2 {
            self.tableView.deleteRows(at: [IndexPath(row: 1, section: 1)], with: .automatic)
        }

    }
    
    func segmentedValueChanged(sender: UISegmentedControl) {
        
        switch sender.tag {
        case 1:
            UserDataManager.sharedInstance.userDefaults.set(sender.selectedSegmentIndex, forKey: "password_type")
        case 2:
            UserDataManager.sharedInstance.userDefaults.set(sender.selectedSegmentIndex, forKey: "duration_type")
            self.tableView.reloadSections(IndexSet(integersIn: 2...2), with: .automatic)
        default:
            break
        }
    }
}
