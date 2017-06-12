//
//  UserProfileViewModel.swift
//  SampleProject
//
//  Created by Pavan Kumar Valluru on 10.04.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import UIKit

class UserProfileTableViewModel: ConfigurableTableViewModel {
    
    // array of tuples with title text and cell properties to configure, also used to calculate number of rows in section
    var section_0_rows: [(name: String, properties: (type: Int, category: Int))] {
     
        get {
            return [(name: "Name",
                     properties: (type: CellType.DetailCell.rawValue, category: ConfigurableTableDetailCell.DetailCellCategory.FullName.rawValue))
                    ,(name: "Anzeigename",
                     properties: (type: CellType.DetailCell.rawValue, category: ConfigurableTableDetailCell.DetailCellCategory.DisplayName.rawValue))
                    ,(name: "Beruf",
                     properties: (type: CellType.DetailCell.rawValue, category: ConfigurableTableDetailCell.DetailCellCategory.Profession.rawValue))
                    ,(name: "Email",
                      properties: (type: CellType.DetailCell.rawValue, category: ConfigurableTableDetailCell.DetailCellCategory.Email.rawValue))
                    ,(name: "PushNotifications",
                      properties: (type: CellType.SwitchCell.rawValue, category: ConfigurableTableSwitchCell.SwitchCellCategory.PushNotifications.rawValue))
                   ]
        }
    }
    
    var section_1_rows: [(name: String, properties: (type: Int, category: Int))] =
                    [(name: NSLocalizedString("Have a nice day!", comment: ""),
                      properties: (type: CellType.ButtonCell.rawValue, category: ConfigurableTableButtonCell.ButtonCellCategory.Login.rawValue))
                     ,(name: NSLocalizedString("Happy coding!", comment: ""),
                      properties: (type: CellType.ButtonCell.rawValue, category: ConfigurableTableButtonCell.ButtonCellCategory.Login.rawValue))
                     ,(name: NSLocalizedString("Swift is the future!", comment: ""),
                      properties: (type: CellType.ButtonCell.rawValue, category: ConfigurableTableButtonCell.ButtonCellCategory.Login.rawValue))
                    ]
    
    
    override init() {
        super.init()
        rows_in_section = [section_0_rows, section_1_rows]
        section_headers = ["Persönliche Daten",""]
    }

}
