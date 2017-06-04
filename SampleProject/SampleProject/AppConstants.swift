//
//  AppConstants.swift
//  SampleProject
//
//  Created by Pavan Kumar Valluru on 03.06.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import UIKit

class AppConstants {
    
    enum UserDefaultsKeys: String {
        case USER_EMAIL = "user_email", USER_PASSWORD = "user_password", USER_FIRSTNAME = "firstName", USER_ACCESS_TOKEN = "access_token",
        USER_LASTNAME = "lastName", USER_LANGUAGE = "language", PUSH_NOTIFICATIONS = "push_notifications"
    }

    
    struct Colors {
        static let MYAPP_BLUE_COLOR = UIColor(red: 0, green: 151, blue: 231)
        static let TABLE_GRAY_BACKGROUND = UIColor(red: 239, green: 239, blue: 239)
        static let TOOL_BAR_BG_COLOR = UIColor(red: 245, green: 245, blue: 245)
        static let TOOL_BAR_TEXT_COLOR = UIColor(red: 105, green: 105, blue: 105)
        static let RED_BACKGROUND = UIColor(red: 194, green: 17, blue: 38)
        static let NAVIGATION_BACKGROUND = UIColor(red: 56, green: 56, blue: 56)
        static let MYAPP_WHITE = UIColor.white
        static let MYAPP_TEXT_BLUE = UIColor(red: 38, green: 110, blue: 174)
        static let MYAPP_TEXT_BLACK = UIColor(red: 68, green: 68, blue: 68)
        static let MYAPP_DETAIL_TEXT_GRAY = UIColor(red: 143, green: 142, blue: 148)
        static let MYAPP_RED = UIColor(red: 194, green: 17, blue: 38)
        static let FOOTER_TEXT_COLOR = UIColor(red: 157, green: 158, blue: 161)
        static let DAYS_BAR_BG_COLOR = UIColor(red: 151, green: 151, blue: 151)
        static let DAYS_BAR_CELL_COLOR = UIColor(red: 239, green: 240, blue: 244)
        static let DAYS_BAR_SAT_CELL_COLOR = UIColor(red: 210, green: 228, blue: 244)
        static let DAYS_BAR_SUN_CELL_COLOR = UIColor(red: 184, green: 210, blue: 233)
        static let MYAPP_TABLE_BACKGROUND = UIColor(red: 248, green: 249, blue: 251)
        static let MYAPP_HEADER_BACKGROUND = UIColor(red: 239, green: 239, blue: 239)
        static let MYAPP_TODAY_COLOR = UIColor(red: 255, green: 150, blue: 20)
        static let MYAPP_BLUE_LAYER_COLOR = UIColor(red: 82, green: 146, blue: 203)
    }
    
    struct Fonts {
        static let SF_UIText_Regular_9: UIFont = AppConstants.getFontFromResourcesWith(name: "SFUIText-Regular", size: 9)
        static let SF_UIText_Regular_11: UIFont = AppConstants.getFontFromResourcesWith(name: "SFUIText-Regular", size: 11)
        static let SF_UIText_Regular_12: UIFont = AppConstants.getFontFromResourcesWith(name: "SFUIText-Regular", size: 12)
        static let SF_UIText_Regular_13: UIFont = AppConstants.getFontFromResourcesWith(name: "SFUIText-Regular", size: 13)
        static let SF_UIText_Regular_15: UIFont = AppConstants.getFontFromResourcesWith(name: "SFUIText-Regular", size: 15)
        static let SF_UIText_Regular_16: UIFont = AppConstants.getFontFromResourcesWith(name: "SFUIText-Regular", size: 16)
        static let SF_UIText_Regular_17: UIFont = AppConstants.getFontFromResourcesWith(name: "SFUIText-Regular", size: 17)
        
        static let SF_UIText_Bold_13: UIFont = AppConstants.getFontFromResourcesWith(name: "SFUIText-Bold", size: 13)
        static let SF_UIText_Bold_17: UIFont = AppConstants.getFontFromResourcesWith(name: "SFUIText-Bold", size: 17)
        
        static let SF_UIText_Light_20: UIFont = AppConstants.getFontFromResourcesWith(name: "SFUIText-Light", size: 20)
        
        static let SF_UIText_SemiBold_10: UIFont = AppConstants.getFontFromResourcesWith(name: "SFUIText-Semibold", size: 10)
        static let SF_UIText_SemiBold_11: UIFont = AppConstants.getFontFromResourcesWith(name: "SFUIText-Semibold", size: 11)
        static let SF_UIText_SemiBold_12: UIFont = AppConstants.getFontFromResourcesWith(name: "SFUIText-Semibold", size: 12)
        static let SF_UIText_SemiBold_16: UIFont = AppConstants.getFontFromResourcesWith(name: "SFUIText-Semibold", size: 16)
        static let SF_UIText_SemiBold_17: UIFont = AppConstants.getFontFromResourcesWith(name: "SFUIText-Semibold", size: 17)
        
        static let SF_UIText_Medium_12: UIFont = AppConstants.getFontFromResourcesWith(name: "SFUIText-Medium", size: 12)
        static let SF_UIText_Medium_13: UIFont = AppConstants.getFontFromResourcesWith(name: "SFUIText-Medium", size: 13)
        static let SF_UIText_Medium_15: UIFont = AppConstants.getFontFromResourcesWith(name: "SFUIText-Medium", size: 15)
        static let SF_UIText_Medium_16: UIFont = AppConstants.getFontFromResourcesWith(name: "SFUIText-Medium", size: 16)
        static let SF_UIText_Medium_17: UIFont = AppConstants.getFontFromResourcesWith(name: "SFUIText-Medium", size: 17)
        static let SF_UIText_Medium_18: UIFont = AppConstants.getFontFromResourcesWith(name: "SFUIText-Medium", size: 18)
        static let SF_UIText_Medium_20: UIFont = AppConstants.getFontFromResourcesWith(name: "SFUIText-Medium", size: 20)
        
        static let SF_UIText_Italic_13: UIFont = AppConstants.getFontFromResourcesWith(name: "SFUIText-Italic", size: 13)
        
        static let SF_UIDisplay_Light_13: UIFont = AppConstants.getFontFromResourcesWith(name: "SFUIDisplay-Light", size: 13)
        static let SF_UIDisplay_Light_20: UIFont = AppConstants.getFontFromResourcesWith(name: "SFUIDisplay-Light", size: 20)
        static let SF_UIDisplay_Light_28: UIFont = AppConstants.getFontFromResourcesWith(name: "SFUIDisplay-Light", size: 28)
        
        static let SF_UIDisplay_UltraLight_15: UIFont = AppConstants.getFontFromResourcesWith(name: "SFUIDisplay-Ultralight", size: 15)
        
        static let SF_UIDisplay_Regular_16: UIFont = AppConstants.getFontFromResourcesWith(name: "SFUIDisplay-Regular", size: 16)
        static let SF_UIDisplay_Regular_36: UIFont = AppConstants.getFontFromResourcesWith(name: "SFUIDisplay-Regular", size: 36)
        
    }
    
    // loads a font and exits with a descriptive error message if unsuccessful
    static func getFontFromResourcesWith(name: String, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: name, size: size) else {
            fatalError("Could not load font \(name) with size \(size)")
        }
        return font
    }
    
    static func setDefaults()
    {
        let userDefaults: [String: Any] = [
                "duration_type" : 0,
                "currentIndex"  : 0,
                "password_type" : 0,
                "update_pin"    : true,
                "pin_value"     : "",
                "id_value"      : "",
                "current_month" : true,
                "previous_month": true,
                "next_month"    : true,
                "InfosTyp1"     : true,
                "InfosTyp2"     : false,
                "profession"    : "",
            ]
        UserDefaults.standard.register(defaults: userDefaults)
    }

}
