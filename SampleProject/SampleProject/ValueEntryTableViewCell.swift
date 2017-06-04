//
//  ValueEntryTableViewCell.swift
//  OffBlock3
//
//  Created by Pavan Kumar Valluru on 07.04.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

protocol ValueEntryCellDelegate: ConfigurableTableViewCellDelegate {
    
}

protocol ValueEntryCellDataSource: ConfigurableTableViewCellDataSource {
    
}

extension ValueEntryCellDataSource {
    
    var textFieldValue: String {
        get {
            switch self.category {
                case ConfigurableTableDetailCell.DetailCellCategory.Email.rawValue:
                    return UserDataManager.sharedInstance.email
                case ConfigurableTableDetailCell.DetailCellCategory.FirstName.rawValue:
                    return UserDataManager.sharedInstance.firstName
                case ConfigurableTableDetailCell.DetailCellCategory.LastName.rawValue:
                    return UserDataManager.sharedInstance.lastName
                default:
                    return ""
            }
        }
    }
}

class ValueEntryTableViewCell: ConfigurableTableViewCell {
    
    var title: UILabel!
    var textField: UITextField!
    
    func configure(withViewModel viewModel: ValueEntryTableViewCellViewModel) {
        
        super.configure(withViewModel: viewModel)
        
        self.backgroundColor = delegate?.backgroundColor
        
        title =  UILabel()
        title.backgroundColor = UIColor.clear
        title.textColor = AppConstants.Colors.TOOL_BAR_TEXT_COLOR
        title.font = AppConstants.Fonts.SF_UIText_Regular_13
        title.text = dataSource!.title.uppercased()
        self.contentView.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top).offset(13)
            make.leading.equalTo(self.contentView.snp.leading).offset(16)
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-16)
            make.height.equalTo(18)
        }
        
        textField = UITextField()
        textField.backgroundColor = UIColor.clear
        self.contentView.addSubview(textField)
        textField.snp.makeConstraints { make -> Void in
            make.top.equalTo(title.snp.bottom).offset(12)
            make.leading.equalTo(self.contentView.snp.leading).offset(16)
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-16)
            make.height.equalTo(19)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-13)
        }
        
        // set standard values for text field
        textField.clearButtonMode = .whileEditing
        textField.tintColor = UIColor.black
        
        textField?.font = delegate?.textFont
        textField?.textColor = delegate?.textColor
        textField?.text = (dataSource as! ValueEntryCellDataSource).textFieldValue

    }

}

extension ValueEntryTableViewCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //print(textField.text!)
    }
}
