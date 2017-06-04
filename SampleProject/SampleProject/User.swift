//
//  User.swift
//  SampleProject
//
//  Created by Pavan Kumar Valluru on 03.06.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation


class User: NSCoder, NSCoding {
    
    // required
    var id: Int = 0
    var username: String = ""
    var initials: String {
        get {
            if username.characters.count > 1 {
                return "H/F"
            }
            return "-"
        }
    }
    
    // optional
    var first_name: String = ""
    var last_name: String = ""
    var email: String = ""
    var password: String = ""
    var position: String = ""
    var image_url: String = ""
    
    var fullname: String {
        get {
            return "\(first_name) \(last_name)"
        }
    }
    
    override init() {
        
    }
    
    init?(dict: [String: Any]) {
        guard let username = dict["username"] as? String else {
            debugPrint("name or image_url is missing")
            return nil
        }
        
        self.username = username
        self.first_name = username.components(separatedBy: " ").first!
        self.last_name = username.components(separatedBy: " ").last!
        
        if let image_url = dict["image_url"] as? String {
            self.image_url = image_url
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeInteger(forKey: "id")
        self.username = aDecoder.decodeObject(forKey: "username") as? String ?? ""
        self.first_name = aDecoder.decodeObject(forKey: "first_name") as? String ?? ""
        self.last_name = aDecoder.decodeObject(forKey: "last_name") as? String ?? ""
        self.email = aDecoder.decodeObject(forKey: "email") as? String ?? ""
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.username, forKey: "username")
        aCoder.encode(self.first_name, forKey: "first_name")
        aCoder.encode(self.last_name, forKey: "last_name")
        aCoder.encode(self.email, forKey: "email")
    }
    
    func userRefDict() -> [String: Any] {
        var dict = [String: Any]()
        dict["username"] = username
        dict["image_url"] = image_url
        return dict
    }
    
}
