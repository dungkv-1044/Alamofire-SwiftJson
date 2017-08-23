//
//  Contact.swift
//  AlamofireDemo
//
//  Created by Khuat Van Dung on 8/23/17.
//  Copyright © 2017 Khuat Van Dung. All rights reserved.
//

import Foundation
import SwiftyJSON
class People {
    var pID: String?
    var name: String?
    var email: String?
    var phone: Phone?
    init?(json: JSON) {
        guard let pID = json["id"].string else {
            return
        }
        guard let name = json["name"].string else {
            return
        }
        guard let email = json["email"].string else {
            return
        }
        self.pID = pID
        self.name = name
        self.email = email
        if let phone = Phone(jsonPhone: json["phone"]) {
            self.phone = phone
        }
    }
}
