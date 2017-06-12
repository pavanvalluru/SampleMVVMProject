//
//  CrewListViewModel.swift
//  SampleProject
//
//  Created by Pavan Kumar Valluru on 08.05.17.
//  Copyright © 2017 Pavan Kumar Valluru. All rights reserved.
//

import Foundation

class FriendsListViewModel: ConfigurableTableViewModel {
    
    // array of tuples with title text and cell properties to configure, also used to calculate number of rows in section
    var section_0_rows: [(name: String, properties: (type: Int, category: Int))] =
        [(name: "",
          properties: (type: 0, category: 0))
    ]
    
    override init() {
        super.init()
        
        rows_in_section = [section_0_rows]
        section_headers = [Date().readableDateString]
    }
    
    // TODO - Remove this. Just for creating dummy contacts data
    func createDummyContacts() -> [User] {
        
        let user00: User = User()
        user00.id = 00
        user00.username = " AC"
        user00.first_name = "Angel"
        user00.last_name = "Casey"
        user00.email = "bbb@bb.com"
        user00.position = "SFO"
        user00.image_url = "http://bootstrap.gallery/everest-v3/img/user1.jpg"
        
        let user01: User = User()
        user01.id = 01
        user01.username = "JR"
        user01.first_name = "Jean"
        user01.last_name = "Ryan"
        user01.email = "aaaa@aaa.com"
        user01.position = "CPT"
        user01.image_url = "https://bootstrapmade.com/demo/themes/Green/img/members3.jpg"
        
        let user02: User = User()
        user02.id = 02
        user02.username = "CK"
        user02.first_name = "Carolyn"
        user02.last_name = "King"
        user02.email = "cc@cc.com"
        user02.position = "P2"
        user02.image_url = "http://bootstrap.gallery/everest-v3/img/user5.jpg"
        
        let user03: User = User()
        user03.id = 03
        user03.username = "JD"
        user03.first_name = "Johnny"
        user03.last_name = "Doyle"
        user03.email = "dd@dd.com"
        user03.position = "FB"
        user03.image_url = ""
        
        let user04: User = User()
        user04.id = 04
        user04.username = "LC"
        user04.first_name = "Lara"
        user04.last_name = "Catty"
        user04.email = "bbb@bb.com"
        user04.position = "SFO"
        user04.image_url = "http://bootstrap.gallery/everest-v3/img/user2.jpg"
        
        let user05: User = User()
        user05.id = 05
        user05.username = "JW"
        user05.first_name = "Jenny"
        user05.last_name = "Weber"
        user05.email = "aaaa@aaa.com"
        user05.position = "CPT"
        user05.image_url = "http://bootstrap.gallery/everest-v3/img/user3.jpg"
        
        let user06: User = User()
        user06.id = 06
        user06.username = "CK"
        user06.first_name = "Carolyn"
        user06.last_name = "King"
        user06.email = "cc@cc.com"
        user06.position = "P2"
        user06.image_url = "http://bootstrap.gallery/everest-v3/img/user4.jpg"
        
        let user07: User = User()
        user07.id = 07
        user07.username = "DB"
        user07.first_name = "David"
        user07.last_name = "Babayan"
        user07.email = "dd@dd.com"
        user07.position = "FB"
        user07.image_url = ""
        
        return [user00,user01,user02,user03,user04,user05,user06,user07]
    }

}
