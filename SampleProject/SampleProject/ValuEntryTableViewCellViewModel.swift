//
//  ValuEntryTableViewCellViewModel.swift
//  SampleProject
//
//  Created by Pavan Kumar Valluru on 07.04.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import UIKit

class ValueEntryTableViewCellViewModel: ConfigurableTableViewCellViewModel {
    
    override init(title: String, category: Int) {
        super.init(title: title, category: category)
    }
}

extension ValueEntryTableViewCellViewModel: ValueEntryCellDelegate {
    
}

extension ValueEntryTableViewCellViewModel: ValueEntryCellDataSource {
    
}
