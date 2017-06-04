//
//  SettingsViewTableCell.swift
//  OffBlock3
//
//  Created by Pavan Kumar Valluru on 04.04.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import UIKit

protocol ConfigurableTableViewDetailCellDelegate: ConfigurableTableViewCellDelegate {
    
    var detailTextColor: UIColor { get }
    
    var detailTextFont: UIFont { get }

}

protocol ConfigurableTableViewDetailCellDataSource: ConfigurableTableViewCellDataSource {
    
}

extension ConfigurableTableViewDetailCellDelegate {

    var detailTextFont: UIFont {
        return AppConstants.Fonts.SF_UIText_Regular_17
    }
    
    var detailTextColor: UIColor {
        return AppConstants.Colors.MYAPP_DETAIL_TEXT_GRAY
    }

}

class ConfigurableTableDetailCell: ConfigurableTableViewCell {
    
    enum DetailCellCategory: Int {
        case Empty = 0, FirstName, LastName, FullName, Profession, Email, Newsletter, Password, Language, PushNotifications, AGB, Impressum, Privacy, OpenSource, DisplayName, ConfigUpdatePassword, ConfigUpdateID
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(withViewModel viewModel: ConfigurableTableDetailCellViewModel) {
        
        super.configure(withViewModel: viewModel)
        
        self.accessoryType = self.delegate!.accessoryType
        self.backgroundColor = self.delegate?.backgroundColor

        self.textLabel?.font = self.delegate?.textFont
        self.textLabel?.textColor = self.delegate?.textColor
        self.textLabel?.text = self.dataSource?.title
        
        self.detailTextLabel?.textColor = self.delegate?.detailTextColor
        
        self.detailTextLabel?.font = (self.delegate as! ConfigurableTableViewDetailCellDelegate).detailTextFont
        self.detailTextLabel?.text = viewModel.detailText//(self.delegate as! ConfigurableTableViewDetailCellDataSource).detailText
        
    }
    
}
