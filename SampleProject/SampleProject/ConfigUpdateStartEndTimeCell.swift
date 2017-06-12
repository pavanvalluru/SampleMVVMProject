//
//  LiveUpdateStartEndTimeCell.swift
//  SampleProject
//
//  Created by Pavan Kumar Valluru on 01.06.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import UIKit

class ConfigUpdateStartEndTimeCell: ConfigurableTableViewCell {
    
    var startValueLabel: UILabel!
    var endValuelabel: UILabel!
    
    var timeFormatter: DateFormatter {
        get {
            // Create date formatter
            let dateFormatter: DateFormatter = DateFormatter()
            // Set date format
            dateFormatter.dateFormat = "HH:mm"
            
            return dateFormatter
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let arrow = UIBezierPath.arrow(from: CGPoint(x:self.contentView.center.x-10, y:self.contentView.center.y), to: CGPoint(x:self.contentView.center.x+11, y:self.contentView.center.y), tailWidth: 1, headWidth: 7, headLength: 7)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = arrow.cgPath
        self.layer.addSublayer(shapeLayer)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            let xLoc = touch.location(in: self).x
            
            if xLoc > self.frame.width/2 {
                endValuelabel.textColor = AppConstants.Colors.MYAPP_TEXT_BLUE
                startValueLabel.textColor = UIColor.black
            } else {
                startValueLabel.textColor = AppConstants.Colors.MYAPP_TEXT_BLUE
                endValuelabel.textColor = UIColor.black
            }
            
        }
        super.touchesBegan(touches, with: event)
    }
    
    func configure(startTime: Date, endTime: Date) {
        
        if startValueLabel == nil {
            startValueLabel = UILabel()
            startValueLabel.font = AppConstants.Fonts.SF_UIText_Regular_16
            startValueLabel.textColor = UIColor.black
            self.contentView.addSubview(startValueLabel)
            startValueLabel.snp.makeConstraints { (make) in
                make.centerY.equalTo(self.contentView.snp.centerY)
                make.leading.equalTo(self.contentView.snp.leading).offset(16)
                make.height.equalTo(20)
            }
        }
        
        if endValuelabel == nil {
            endValuelabel = UILabel()
            endValuelabel.font = AppConstants.Fonts.SF_UIText_Regular_16
            endValuelabel.textColor = UIColor.black
            self.contentView.addSubview(endValuelabel)
            endValuelabel.snp.makeConstraints { (make) in
                make.centerY.equalTo(self.contentView.snp.centerY)
                make.trailing.equalTo(self.contentView.snp.trailing).offset(-16)
                make.height.equalTo(20)
            }
        }
        
        startValueLabel.textColor = UIColor.black
        endValuelabel.textColor = UIColor.black
        
        startValueLabel.text = "\(startTime.currentMonthName) \(startTime.currentYear)"
        endValuelabel.text = "\(endTime.currentMonthName) \(endTime.currentYear)"
        
    }
    
}

