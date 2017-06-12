//
//  ContactCrewCell.swift
//  SampleProject
//
//  Created by Pablo Marcos on 10.05.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class FriendCell: ConfigurableTableViewCell {
    
    var isCellSelected: Bool = false
    
    let userImageViewButton: UIButton = {
        let view = UIButton()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.backgroundColor = UIColor.lightGray
        view.layer.cornerRadius = 24
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppConstants.Fonts.SF_UIText_SemiBold_16
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = AppConstants.Fonts.SF_UIText_Regular_13
        label.textColor = AppConstants.Colors.MYAPP_DETAIL_TEXT_GRAY
        return label
    }()
    
    let commonContactsLabel: UILabel = {
        let label = UILabel()
        label.font = AppConstants.Fonts.SF_UIText_Regular_13
        label.textColor = AppConstants.Colors.MYAPP_TEXT_BLUE
        return label
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(colorLiteralRed: 0.92, green: 0.92, blue: 0.92, alpha: 1.0)
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(userImageViewButton)
        userImageViewButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.leading.equalTo(self).offset(10)
            make.width.equalTo(48)
            make.height.equalTo(48)
            make.top.equalTo(self).offset(20)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(userImageViewButton.snp.trailing).offset(10)
            make.top.equalTo(userImageViewButton.snp.top).offset(-2)
        }
        
        addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(userImageViewButton.snp.trailing).offset(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
        }
        
        addSubview(commonContactsLabel)
        commonContactsLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(userImageViewButton.snp.trailing).offset(10)
            make.top.equalTo(subTitleLabel.snp.bottom).offset(2)
        }
        
        addSubview(seperatorView)
        seperatorView.snp.makeConstraints { (make) in
            make.leading.equalTo(userImageViewButton.snp.trailing).offset(10)
            make.trailing.equalTo(self)
            make.bottom.equalTo(self)
            make.height.equalTo(0.5)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.userImageViewButton.setImage(nil, for: .normal)
        self.titleLabel.text = ""
        self.subTitleLabel.text = ""
        
    }
    
    // TODO - Complete configure method
    func configure(_ contact: User) {
        
        titleLabel.text = getTitle(contact)
        subTitleLabel.text = getSubtitle(contact)
        
        if let imageUrl = URL(string: contact.image_url) {
            userImageViewButton.sd_setImage(with: imageUrl, for: .normal)
        } else {
            userImageViewButton.setTitle(contact.initials, for: .normal)
        }
        
        commonContactsLabel.text = getCommonContacts(contact)
        
    }
    
    func getTitle(_ contact: User)->String{
        return "\(contact.position)  \(contact.first_name) \(contact.last_name)"
    }
    
    func getSubtitle(_ contact: User)->String{
        return "ID:\(contact.id)"
    }
    
    func getCommonContacts(_ contact: User)->String{
        return "13 gemeinsame freunde"
    }
    
    func setCellSelected(_ selected:Bool){
        self.isCellSelected = selected ? true : false
        
        if selected{
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 17, height: 17))
            imageView.image = #imageLiteral(resourceName: "ChatGroupSelectionSelected")
            self.accessoryView = imageView
        }else{
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 17, height: 17))
            imageView.image = #imageLiteral(resourceName: "ChatGroupSelectionNone")
            self.accessoryView = imageView
        }
    }
    
    func startCellSelection(){
        self.isCellSelected = false
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 17, height: 17))
        imageView.image = #imageLiteral(resourceName: "ChatGroupSelectionNone")
        self.accessoryView = imageView
    }
    
    func endCellSelection(){
        self.accessoryView = nil
    }
    
}
