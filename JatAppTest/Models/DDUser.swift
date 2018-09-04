//
//  DDUser.swift
//  JatAppTest
//
//  Created by Duba on 03.09.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

import Foundation
import ObjectMapper

class DDUser : Mappable {
    
    
    var name : String?
    var email : String?
    var accessToken : String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        email <- map["email"]
        accessToken <- map["access_token"]
    }
    
}
