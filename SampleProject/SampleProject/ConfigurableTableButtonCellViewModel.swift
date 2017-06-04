//
//  ConfigurableTableButtonCellviewModel.swift
//  OffBlock3
//
//  Created by Pavan Kumar Valluru on 04.04.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import UIKit

class ConfigurableTableButtonCellViewModel: ConfigurableTableViewCellViewModel {
        
    override init(title: String, category: Int) {
        super.init(title: title, category: category)
    }

}

extension ConfigurableTableButtonCellViewModel: ConfigurableTableViewButtonCellDataSource {
    
}

extension ConfigurableTableButtonCellViewModel: ConfigurableTableViewButtonCellDelegate {
    
}
