//
//  ConfigurableTableViewCellViewModel.swift
//  SampleProject
//
//  Created by Pavan Kumar Valluru on 07.04.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import UIKit

class ConfigurableTableViewCellViewModel {
    
    fileprivate var _backgroundColor: UIColor = AppConstants.Colors.MYAPP_WHITE
    fileprivate var _accessoryType: UITableViewCellAccessoryType = .disclosureIndicator
    fileprivate var _imagePath = ""
    
    fileprivate var _textColor: UIColor = AppConstants.Colors.MYAPP_TEXT_BLACK
    fileprivate var _textFont: UIFont = AppConstants.Fonts.SF_UIText_Regular_17
    fileprivate var _title = "Unnamed"
    
    fileprivate var _detailTextColor = AppConstants.Colors.MYAPP_DETAIL_TEXT_GRAY
    
    fileprivate var _category = 0
    
    init(title: String, category: Int) {
        self._title = title
        self._category = category
    }
}

extension ConfigurableTableViewCellViewModel {
    
    var backgroundColor: UIColor {
        get {
            return self._backgroundColor
        }
        set {
            self._backgroundColor = newValue
        }
    }
    
    var accessoryType: UITableViewCellAccessoryType {
        get {
            return self._accessoryType
        }
        set {
            self._accessoryType = newValue
        }
    }
    
    var textColor: UIColor {
        get {
            return self._textColor
        }
        set {
            self._textColor = newValue
        }
    }
    
    var textFont: UIFont {
        get {
            return self._textFont
        }
        set {
            self._textFont = newValue
        }
    }
    
    var detailTextColor: UIColor {
        get {
            return self._detailTextColor
        }
        set {
            self._detailTextColor = newValue
        }
    }
    
}

extension ConfigurableTableViewCellViewModel {
    
    var title: String {
        get {
            return _title
        }
        set {
            self._title = newValue
        }
    }
    
    var category: Int {
        get {
            return _category
        }
        set {
            self._category = newValue
        }
    }
    
    var imagePath: String {
        get {
            return self._imagePath
        }
        set {
            self._imagePath = newValue
        }
    }
    
}
