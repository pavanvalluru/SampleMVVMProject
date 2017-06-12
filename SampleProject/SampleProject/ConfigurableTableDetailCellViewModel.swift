//
//  ConfigurableTableDetailCellViewModel.swift
//  SampleProject
//
//  Created by Pavan Kumar Valluru on 04.04.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import UIKit

class ConfigurableTableDetailCellViewModel: ConfigurableTableViewCellViewModel {
    
    fileprivate var _detailText: String = ""
    
    override init(title: String, category: Int) {
        super.init(title: title, category: category)

    }
}

extension ConfigurableTableDetailCellViewModel: ConfigurableTableViewDetailCellDelegate {
    
}

extension ConfigurableTableDetailCellViewModel: ConfigurableTableViewDetailCellDataSource {
    
    var detailText: String {
        get {
            if !self._detailText.isEmpty {
                return self._detailText // return custom detail text if possible
            }
            
            switch category {
            case ConfigurableTableDetailCell.DetailCellCategory.FullName.rawValue:
                return UserDataManager.sharedInstance.fullName
            case ConfigurableTableDetailCell.DetailCellCategory.FirstName.rawValue:
                return UserDataManager.sharedInstance.firstName
            case ConfigurableTableDetailCell.DetailCellCategory.LastName.rawValue:
                return UserDataManager.sharedInstance.lastName
            case ConfigurableTableDetailCell.DetailCellCategory.Email.rawValue:
                return UserDataManager.sharedInstance.email
            case ConfigurableTableDetailCell.DetailCellCategory.Profession.rawValue:
                return UserDefaults.standard.string(forKey: "profession") ?? ""
            case ConfigurableTableDetailCell.DetailCellCategory.Password.rawValue:
                return ""
            case ConfigurableTableDetailCell.DetailCellCategory.ConfigUpdateID.rawValue:
                return UserDefaults.standard.string(forKey: "id_value") ?? ""
            case ConfigurableTableDetailCell.DetailCellCategory.ConfigUpdatePassword.rawValue:
                return UserDefaults.standard.string(forKey: "pin_value") ?? ""
            default:
                print("ConfigurableTableDetailCell unrecognised category")
                return ""
            }

        } set {
            self._detailText = newValue
        }
    }
}
