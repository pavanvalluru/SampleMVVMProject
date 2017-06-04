//
//  ConfigurableTableSwitchCellViewModel.swift
//  OffBlock3
//
//  Created by Pavan Kumar Valluru on 04.04.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import UIKit

class ConfigurableTableSwitchCellViewModel: ConfigurableTableViewCellViewModel {
    
    fileprivate var _switchColor: UIColor = AppConstants.Colors.MYAPP_TEXT_BLUE
    
    override init(title: String, category: Int) {
        super.init(title: title, category: category)
    }
}


extension ConfigurableTableSwitchCellViewModel: ConfigurableTableViewSwitchCellDelegate {
    
}

extension ConfigurableTableSwitchCellViewModel: ConfigurableTableViewSwitchCellDataSource {
    
}
