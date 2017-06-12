//
//  ConfigurableTableSubTitleCellViewModel.swift
//  SampleProject
//
//  Created by Pavan Kumar Valluru on 18.04.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import UIKit

class ConfigurableTableSubTitleCellViewModel: ConfigurableTableViewCellViewModel {
    
    override init(title: String, category: Int) {
        super.init(title: title, category: category)
        
    }
}

extension ConfigurableTableSubTitleCellViewModel: ConfigurableTableViewSubTitleCellDelegate {
    
}

extension ConfigurableTableSubTitleCellViewModel: ConfigurableTableViewSubTitleCellDataSource {
    
}

