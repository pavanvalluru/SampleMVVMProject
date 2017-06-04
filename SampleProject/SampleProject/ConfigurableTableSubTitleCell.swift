//
//  ConfigurableTableSubTitleCell.swift
//  OffBlock3
//
//  Created by Pavan Kumar Valluru on 18.04.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import UIKit

protocol ConfigurableTableViewSubTitleCellDelegate: ConfigurableTableViewCellDelegate {
    
    var subTitleTextColor: UIColor { get }
    
    var subTitleTextFont: UIFont { get }
    
}

protocol ConfigurableTableViewSubTitleCellDataSource: ConfigurableTableViewCellDataSource {
    
}

extension ConfigurableTableViewSubTitleCellDelegate {
    
    var subTitleTextFont: UIFont {
        return AppConstants.Fonts.SF_UIText_Regular_13
    }
    
    var subTitleTextColor: UIColor {
        return AppConstants.Colors.MYAPP_DETAIL_TEXT_GRAY
    }
    
}

extension ConfigurableTableViewSubTitleCellDataSource {
    
    var subTitleText: String {
        get {
            switch category {
            case ConfigurableTableSubTitleCell.SubTitleCellCategory.Upgrade.rawValue:
                return "OffBlock BASIC"
            case ConfigurableTableSubTitleCell.SubTitleCellCategory.AboutOffblock.rawValue:
                return "Version \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String)"
            default:
                return "<empty>"
            }
        }
    }
    
    func getImagePath() -> String {
        switch category {
        case ConfigurableTableSubTitleCell.SubTitleCellCategory.Upgrade.rawValue:
            return "HomeActive"
        case ConfigurableTableSubTitleCell.SubTitleCellCategory.Profile.rawValue:
            return "Profile"
        case ConfigurableTableSubTitleCell.SubTitleCellCategory.AboutOffblock.rawValue:
            return "Info"
        default:
            return ""
        }
    }

}

class ConfigurableTableSubTitleCell: ConfigurableTableViewCell {
    
    enum SubTitleCellCategory: Int {
        case Upgrade = 0, Profile, AboutOffblock
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withViewModel viewModel: ConfigurableTableSubTitleCellViewModel) {
        
        super.configure(withViewModel: viewModel)
        
        self.accessoryType = self.delegate!.accessoryType
        self.backgroundColor = self.delegate?.backgroundColor
        
        self.textLabel?.font = self.delegate?.textFont
        self.textLabel?.textColor = self.category == SubTitleCellCategory.Upgrade.rawValue ? AppConstants.Colors.MYAPP_TEXT_BLUE : self.delegate?.textColor
        self.textLabel?.text = self.dataSource?.title
        
        // detailtextlabel is subtitle
        self.detailTextLabel?.font = (self.delegate as! ConfigurableTableViewSubTitleCellDelegate).subTitleTextFont
        self.detailTextLabel?.textColor = (self.delegate as! ConfigurableTableViewSubTitleCellDelegate).subTitleTextColor
        self.detailTextLabel?.text = (self.delegate as! ConfigurableTableViewSubTitleCellDataSource).subTitleText
        
        self.imageView?.image = UIImage(named: (self.dataSource as? ConfigurableTableViewSubTitleCellDataSource)!.getImagePath())
    }

}
