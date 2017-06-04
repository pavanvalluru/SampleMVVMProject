//
//  UserDataManager.swift
//  SampleProject
//
//  Created by Pavan Kumar Valluru on 03.06.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper
import RealmSwift


public class UserDataManager: NSObject {
    
    var keychain: KeychainWrapper!
    var userDefaults: UserDefaults!
    
    static let sharedInstance: UserDataManager = {
        let instance = UserDataManager()
        // to do additional set up if required
        instance.keychain = KeychainWrapper.standard
        instance.userDefaults = UserDefaults.standard
        
        return instance
    }()
    
    var isLoggedIn: Bool {
        get {
            return !self.access_token.isEmpty // if the access_token is not empty then the user is logged in
        }
    }
    
    var access_token: String {
        get {
            return self.keychain.string(forKey: AppConstants.UserDefaultsKeys.USER_ACCESS_TOKEN.rawValue) ?? "" // returns left side value if not nil else empty string
        }
        set {
            // if access token is resest then reset user details also
            if(newValue.isEmpty) {
                self.firstName = ""
                self.lastName = ""
            }
            self.keychain.set(newValue, forKey: AppConstants.UserDefaultsKeys.USER_ACCESS_TOKEN.rawValue)
        }
    }
    
    var email: String {
        get {
            return self.keychain.string(forKey: AppConstants.UserDefaultsKeys.USER_EMAIL.rawValue) ?? "" // returns left side value if not nil else empty string
        }
        set {
            self.keychain.set(newValue, forKey: AppConstants.UserDefaultsKeys.USER_EMAIL.rawValue)
        }
    }
    
    var password: String {
        get {
            return self.keychain.string(forKey: AppConstants.UserDefaultsKeys.USER_PASSWORD.rawValue) ?? "" // returns left side value if not nil else empty string
        }
        set {
            self.keychain.set(newValue, forKey: AppConstants.UserDefaultsKeys.USER_PASSWORD.rawValue)
        }
    }
    
    var firstName: String {
        get {
            return self.userDefaults.value(forKey: AppConstants.UserDefaultsKeys.USER_FIRSTNAME.rawValue) as? String ?? "" // returns left side value if not nil else empty string
        }
        set {
            self.userDefaults.set(newValue, forKey: AppConstants.UserDefaultsKeys.USER_FIRSTNAME.rawValue)
        }
    }
    
    var lastName: String {
        get {
            return self.userDefaults.value(forKey: AppConstants.UserDefaultsKeys.USER_LASTNAME.rawValue) as? String ?? "" // returns left side value if not nil else empty string
        }
        set {
            self.userDefaults.set(newValue, forKey: AppConstants.UserDefaultsKeys.USER_LASTNAME.rawValue)
        }
    }
    
    var fullName: String {
        get {
            return firstName.appending(lastName.isEmpty ? "" : " \(lastName)") // returns left side value if not nil else empty string
        }
    }
    
    func saveUserDataLocal(_ data: [String:Any]) {        
        for (key, value) in data {
            self.userDefaults.set(value, forKey: "\(key)")
        }
    }
    
    func getValueFromKeychain(forKey: String) -> String? {
        
        return self.keychain.string(forKey: forKey) ?? ""
    }
    
    func setValueInKeychain(forKey: String, value: String) {
        
        self.keychain.set(value.data(using: .utf8)!, forKey: forKey)
    }
    
}

