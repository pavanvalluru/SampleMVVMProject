//
//  AppDelegate.swift
//  SampleProject
//
//  Created by Pavan Kumar Valluru on 04.06.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var shortcutItem: UIApplicationShortcutItem?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // navigation bar appearance setup for complete app
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = AppConstants.Colors.TOOL_BAR_BG_COLOR
        UINavigationBar.appearance().barTintColor = AppConstants.Colors.TOOL_BAR_BG_COLOR
        UINavigationBar.appearance().tintColor = AppConstants.Colors.MYAPP_TEXT_BLUE
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black]
        
        UIBarButtonItem.appearance().tintColor = AppConstants.Colors.TOOL_BAR_TEXT_COLOR
        
        // initiate user defaults
        AppConstants.setDefaults()
        
        // handle application shortcutitems
        var performShortcutDelegate = true
        // If a shortcut was launched, display its information and take the appropriate action
        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            
            self.shortcutItem = shortcutItem
            // This will block "performActionForShortcutItem:completionHandler" from being called.
            performShortcutDelegate = false
        }
        else
        {
            self.window?.rootViewController = RootNavigationController(rootViewController: RootPageViewController()) // this will automatically initiates page view controller
            self.window?.makeKeyAndVisible()
        }
        
        return performShortcutDelegate
    }
}

