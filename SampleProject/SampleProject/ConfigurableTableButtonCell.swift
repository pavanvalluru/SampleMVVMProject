//
//  ConfigurableTableButtonCell.swift
//  OffBlock3
//
//  Created by Pavan Kumar Valluru on 04.04.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import UIKit

protocol ConfigurableTableViewButtonCellDelegate: ConfigurableTableViewCellDelegate {
    var textAlignment: NSTextAlignment { get }
}

protocol ConfigurableTableViewButtonCellDataSource: ConfigurableTableViewCellDataSource {
    
}

extension ConfigurableTableViewButtonCellDelegate {
    
    var textAlignment: NSTextAlignment {
        get {
            return .left
        }
    }
}

class ConfigurableTableButtonCell: ConfigurableTableViewCell {
    
    enum ButtonCellCategory: Int {
        case DeleteEvents = 0, DeleteAccount, Logout, Login, ImportCalendar, ImportMonth, ConfigUpdate
    }
    
    func configure(withViewModel viewModel: ConfigurableTableButtonCellViewModel) {
        super.configure(withViewModel: viewModel)
        
        switch self.category {
        case ButtonCellCategory.DeleteEvents.rawValue:
            self.backgroundColor = AppConstants.Colors.MYAPP_TEXT_BLUE
            self.textLabel?.textColor = AppConstants.Colors.MYAPP_WHITE
            self.textLabel?.font = AppConstants.Fonts.SF_UIText_Medium_16
            
        case ButtonCellCategory.DeleteAccount.rawValue:
            self.backgroundColor = delegate?.backgroundColor
            self.textLabel?.textColor = AppConstants.Colors.MYAPP_RED
            self.textLabel?.font = delegate?.textFont
            
        default:
            self.backgroundColor = delegate?.backgroundColor
            self.textLabel?.textColor = AppConstants.Colors.MYAPP_TEXT_BLUE
            self.textLabel?.font = delegate?.textFont

        }
        
        self.textLabel?.textAlignment = (delegate as? ConfigurableTableViewButtonCellDelegate)!.textAlignment
        self.textLabel?.text = self.dataSource!.title
        
    }
    
}
