//
//  ConfigurableTableViewCell.swift
//  SampleProject
//
//  Created by Pavan Kumar Valluru on 07.04.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import UIKit

class ConfigurableTableViewCell: UITableViewCell {
    
    var category: Int!
    var dataSource: ConfigurableTableViewCellDataSource?
    var delegate: ConfigurableTableViewCellDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withViewModel viewModel: ConfigurableTableViewCellViewModel) {
        
        self.dataSource = viewModel as? ConfigurableTableViewCellDataSource
        self.delegate = viewModel as? ConfigurableTableViewCellDelegate
        
        self.category = self.dataSource?.category
        
        //self.imageView?.image = UIImage(named: self.dataSource!.imagePath)
    }
}

protocol ConfigurableTableViewCellDelegate {
    
    var backgroundColor: UIColor { get set }
    var accessoryType: UITableViewCellAccessoryType { get set }

    var textColor: UIColor { get set }
    var textFont: UIFont { get set }
    
    var detailTextColor: UIColor { get set }
    
}

protocol ConfigurableTableViewCellDataSource {
    var title: String { get set }
    var category: Int { get set }
    var imagePath: String { get set }
    
    func getImagePath() -> String

}

extension ConfigurableTableViewCellDelegate {
    
    var backgroundColor: UIColor {
        return AppConstants.Colors.MYAPP_WHITE
    }
    
    var textColor: UIColor {
        return AppConstants.Colors.MYAPP_TEXT_BLACK
    }
    
    var textFont: UIFont {
        return AppConstants.Fonts.SF_UIText_Regular_17
    }
    
    var accessoryType: UITableViewCellAccessoryType {
        return .disclosureIndicator
    }
}

extension ConfigurableTableViewCellDataSource {
    
    var title: String {
        return "Unnamed"
    }
    
    var category: Int {
        return 0
    }
    
    var imagePath: String {
        get {
            return ""
        }
    }
    
    func getImagePath() -> String {
        return ""
    }

}


