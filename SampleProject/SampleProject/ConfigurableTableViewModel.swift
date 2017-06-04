//
//  ConfigurableTableViewModel.swift
//  OffBlock3
//
//  Created by Pavan Kumar Valluru on 11.04.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation

protocol ConfigurableTableViewModelProtocol {
    
    var rows_in_section: [[(name: String, properties: (type: Int, category: Int))]] { get set }
    var section_headers: [String] { get set }
}

enum  CellType: Int {
    case ButtonCell = 0, DetailCell, SwitchCell, PictureInCell, SubTitleCell, ValueEntry, ConfigUpdateStartEndTimeCell
}

class ConfigurableTableViewModel {
    fileprivate var _section_headers: [String] = []
    fileprivate var _rows_in_section: [[(name: String, properties: (type: Int, category: Int))]] = []
    
}

extension ConfigurableTableViewModel: ConfigurableTableViewModelProtocol {
    
    var rows_in_section: [[(name: String, properties: (type: Int, category: Int))]] {
        get {
            return self._rows_in_section
        }
        set {
            self._rows_in_section = newValue
        }
    }
    
    var section_headers: [String] {
        get {
            return self._section_headers
        }
        set {
            self._section_headers = newValue
        }
    }
}
