//
//  ConfigurableTablePictureInCell.swift
//  SampleProject
//
//  Created by Pavan Kumar Valluru on 04.04.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import UIKit

protocol ConfigurableTableViewPictureInCellDelegate: ConfigurableTableViewCellDelegate {
    
}

protocol ConfigurableTableViewPictureInCellDataSource: ConfigurableTableViewCellDataSource {

}

// data source stuff
extension ConfigurableTableViewPictureInCellDataSource {
    
    func getImagePath() -> String {
        
        switch self.category {
        case ConfigurableTablePictureInCell.PictureInCellCategory.Profile.rawValue:
            return "Profile" // TODO profile pic
        case ConfigurableTablePictureInCell.PictureInCellCategory.Settings.rawValue:
            return "Settings"
        case ConfigurableTablePictureInCell.PictureInCellCategory.Statistic.rawValue:
            return "Statistic"
        case ConfigurableTablePictureInCell.PictureInCellCategory.LiveUpdate.rawValue:
            return "Update"
        case ConfigurableTablePictureInCell.PictureInCellCategory.Dienstplanauswertung.rawValue:
            return "edp"
        case ConfigurableTablePictureInCell.PictureInCellCategory.Steuererklärung.rawValue:
            return "edp"
        case ConfigurableTablePictureInCell.PictureInCellCategory.Support.rawValue:
            return "Message"
        case ConfigurableTablePictureInCell.PictureInCellCategory.ReportBug.rawValue:
            return "Bug"
        case ConfigurableTablePictureInCell.PictureInCellCategory.Import.rawValue:
            return "Import"
        case ConfigurableTablePictureInCell.PictureInCellCategory.Currency.rawValue:
            return "flag_de"
        default:
            return ""
        }
    }
    
}

class ConfigurableTablePictureInCell: ConfigurableTableViewCell {
    
    enum PictureInCellCategory: Int {
        case Profile = 0, Settings, Statistic, LiveUpdate, Dienstplanauswertung, Steuererklärung, Support, ReportBug, Import, Currency
    }
    
    func configure(withViewModel viewModel: ConfigurableTablePictureInCellViewModel) {
        super.configure(withViewModel: viewModel)

        self.backgroundColor = delegate?.backgroundColor
        
        if (self.category == PictureInCellCategory.Dienstplanauswertung.rawValue || self.category == PictureInCellCategory.Steuererklärung.rawValue) {
            self.accessoryType = .none
        }else {
            self.accessoryType = delegate!.accessoryType
        }

        self.textLabel?.font = delegate?.textFont
        self.textLabel?.textColor = self.delegate?.textColor
        self.textLabel?.text = self.dataSource!.title
        
        self.imageView?.image = UIImage(named: (self.dataSource as? ConfigurableTableViewPictureInCellDataSource)!.getImagePath())
    }
}
