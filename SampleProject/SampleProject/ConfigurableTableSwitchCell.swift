//
//  ConfigurableTableSwitchCell.swift
//  OffBlock3
//
//  Created by Pavan Kumar Valluru on 04.04.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import UIKit

protocol ConfigurableTableViewSwitchCellDelegate: ConfigurableTableViewCellDelegate {
    func onSwitchToggle(category: Int, status: Bool)
}

protocol ConfigurableTableViewSwitchCellDataSource: ConfigurableTableViewCellDataSource {
    var switchColor: UIColor { get }
    var switchOn: Bool { get }
}

// data source stuff
extension ConfigurableTableViewSwitchCellDataSource {
    
    var switchColor: UIColor {
        get {
            return AppConstants.Colors.MYAPP_TEXT_BLUE
        }
    }
    
    var switchOn: Bool {
        get {
            switch self.category {
            case ConfigurableTableSwitchCell.SwitchCellCategory.PushNotifications.rawValue:
                return UserDefaults.standard.bool(forKey: AppConstants.UserDefaultsKeys.PUSH_NOTIFICATIONS.rawValue)
            case ConfigurableTableSwitchCell.SwitchCellCategory.PreviousMonth.rawValue:
                return UserDefaults.standard.bool(forKey: "previous_month")
            case ConfigurableTableSwitchCell.SwitchCellCategory.CurrentMonth.rawValue:
                return UserDefaults.standard.bool(forKey: "current_month")
            case ConfigurableTableSwitchCell.SwitchCellCategory.NextMonth.rawValue:
                return UserDefaults.standard.bool(forKey: "next_month")
            case ConfigurableTableSwitchCell.SwitchCellCategory.InfosTyp1.rawValue:
                return UserDefaults.standard.bool(forKey: "InfosTyp1")
            case ConfigurableTableSwitchCell.SwitchCellCategory.InfosTyp2.rawValue:
                return UserDefaults.standard.bool(forKey: "InfosTyp2")
            case ConfigurableTableSwitchCell.SwitchCellCategory.ConfigPIN.rawValue:
                return UserDefaults.standard.bool(forKey: "update_pin")
            case ConfigurableTableSwitchCell.SwitchCellCategory.ConfigID.rawValue:
                return UserDefaults.standard.bool(forKey: "currentIndex")
            default:
                return false
            }
        }
    }
}

// delegate stuff
extension ConfigurableTableViewSwitchCellDelegate {
    
    func onSwitchToggle(category: Int, status: Bool) {
        
        switch category {
        case ConfigurableTableSwitchCell.SwitchCellCategory.PushNotifications.rawValue:
            UserDefaults.standard.set(status, forKey: AppConstants.UserDefaultsKeys.PUSH_NOTIFICATIONS.rawValue)
        case ConfigurableTableSwitchCell.SwitchCellCategory.PreviousMonth.rawValue:
            UserDefaults.standard.set(status, forKey: "previous_month")
        case ConfigurableTableSwitchCell.SwitchCellCategory.CurrentMonth.rawValue:
            UserDefaults.standard.set(status, forKey: "current_month")
        case ConfigurableTableSwitchCell.SwitchCellCategory.NextMonth.rawValue:
            UserDefaults.standard.set(status, forKey: "next_month")
        case ConfigurableTableSwitchCell.SwitchCellCategory.InfosTyp1.rawValue:
            UserDefaults.standard.set(status, forKey: "InfosTyp1")
        case ConfigurableTableSwitchCell.SwitchCellCategory.InfosTyp2.rawValue:
            UserDefaults.standard.set(status, forKey: "InfosTyp2")
        case ConfigurableTableSwitchCell.SwitchCellCategory.ConfigPIN.rawValue:
            UserDefaults.standard.set(status, forKey: "update_pin")
        case ConfigurableTableSwitchCell.SwitchCellCategory.ConfigID.rawValue:
            UserDefaults.standard.set(status, forKey: "currentIndex")
        default:
            print("category not found")
        }
    }
    
    // implement other properties here if needs configuration otherwise default values will be used
}

class ConfigurableTableSwitchCell: ConfigurableTableViewCell {
    
    @IBOutlet var switchToggle: UISwitch!
    
    enum SwitchCellCategory: Int {
        case PushNotifications = 0, PreviousMonth, NextMonth, CurrentMonth, InfosTyp1, InfosTyp2, ConfigPIN, ConfigID
    }
    
    func configure(withViewModel viewModel: ConfigurableTableSwitchCellViewModel) {
        super.configure(withViewModel: viewModel)
        
        self.switchToggle = UISwitch()
        self.switchToggle.setOn((self.dataSource as? ConfigurableTableViewSwitchCellDataSource)!.switchOn, animated: true)
        self.switchToggle.onTintColor = (self.dataSource as? ConfigurableTableViewSwitchCellDataSource)?.switchColor
        switchToggle.addTarget(self, action: #selector(onSwitchToggle), for: .valueChanged)
        
        self.selectionStyle = .none
        self.accessoryView = switchToggle
        self.backgroundColor = delegate?.backgroundColor
        
        self.textLabel?.font = delegate?.textFont
        self.textLabel?.textColor = delegate?.textColor
        self.textLabel?.text = self.dataSource!.title
        
    }
    
    @IBAction func onSwitchToggle() {
        (self.delegate as? ConfigurableTableViewSwitchCellDelegate)?.onSwitchToggle(category: self.category, status: switchToggle.isOn)
    }
}
