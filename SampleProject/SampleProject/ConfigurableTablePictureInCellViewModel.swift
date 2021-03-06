//
//  ConfigurableTableProfilePicViewModel.swift
//  SampleProject
//
//  Created by Pavan Kumar Valluru on 04.04.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import UIKit

class ConfigurableTablePictureInCellViewModel: ConfigurableTableViewCellViewModel {
    
    override init(title: String, category: Int) {
        super.init(title: title, category: category)
    }
}

extension ConfigurableTablePictureInCellViewModel: ConfigurableTableViewPictureInCellDelegate {
    
}

extension ConfigurableTablePictureInCellViewModel: ConfigurableTableViewPictureInCellDataSource {
    
}
