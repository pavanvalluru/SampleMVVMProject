//
//  ValueSelectionCellView.swift
//  SampleProject
//
//  Created by Pavan Kumar Valluru on 07.04.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import UIKit

protocol ValueSelectionCellDelegate: ConfigurableTableViewCellDelegate {
    
}

protocol ValueSelectionCellDataSource: ConfigurableTableViewCellDataSource {
    
}


extension ValueSelectionCellDataSource {
    
    var accessoryImageName: String {
        get {
            return ""
        }
    }
    
    var selectedIndex: Int {
        get {
            switch category {
            case ValueSelectionCellViewModel.ValueSelectionCategory.Language.rawValue:
                return UserDataManager.sharedInstance.userDefaults.integer(forKey: AppConstants.UserDefaultsKeys.USER_LANGUAGE.rawValue)
            case ValueSelectionCellViewModel.ValueSelectionCategory.Airline.rawValue:
                return UserDataManager.sharedInstance.userDefaults.integer(forKey: "currentIndex")
            default:
                return 0
            }
        }
    }
    
}

class ValueSelectionCellView: ConfigurableTableViewCell {
    
    func configure(withViewModel viewModel: ValueSelectionCellViewModel) {
        super.configure(withViewModel: viewModel)
        
        self.selectionStyle = .none
        
        if ((self.dataSource as? ValueSelectionCellDataSource)!.selectedIndex == viewModel.category_items.index(of: self.dataSource!.title)) {
            self.accessoryType = .checkmark
        }else {
            self.accessoryType = .none
        }
        
        self.backgroundColor = delegate?.backgroundColor
        
        self.textLabel?.font = delegate?.textFont
        self.textLabel?.textColor = delegate?.textColor
        self.textLabel?.text = dataSource!.title
        
        self.imageView?.image = UIImage(named: (self.dataSource as? ValueSelectionCellDataSource)!.imagePath)
                
    }
    
    func saveSelectedIndex(index: Int) {
        switch category {
        case ValueSelectionCellViewModel.ValueSelectionCategory.Language.rawValue:
            UserDataManager.sharedInstance.userDefaults.set(index, forKey: AppConstants.UserDefaultsKeys.USER_LANGUAGE.rawValue)
        case ValueSelectionCellViewModel.ValueSelectionCategory.Airline.rawValue:
            UserDataManager.sharedInstance.userDefaults.set(index, forKey: "currentIndex")
        default:
            print("no case found to save")
            
        }
    }
    
}
