//
//  Phone.swift
//  AlamofireDemo
//
//  Created by Khuat Van Dung on 8/23/17.
//  Copyright © 2017 Khuat Van Dung. All rights reserved.
//

import Foundation
import SwiftyJSON
class Phone {
    var mobile: String?
    var home: String?
    var office: String?
    init?(jsonPhone: JSON) {
        self.mobile = jsonPhone["mobile"].stringValue
        self.home = jsonPhone["home"].stringValue
        self.office = jsonPhone["office"].stringValue
    }
}
