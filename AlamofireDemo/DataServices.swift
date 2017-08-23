//
//  DataServices.swift
//  AlamofireDemo
//
//  Created by Khuat Van Dung on 8/23/17.
//  Copyright © 2017 Khuat Van Dung. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
class DataServices {
    var url = "http://api.androidhive.info/contacts/"
    static let shared: DataServices = DataServices()
    var contact: [People] = []
    func requestJSONFromURL() {
        contact = []
        Alamofire.request(url).responseJSON { (responseData) -> Void in
            switch responseData.result {
            case .success(let value as [String: AnyObject]):
                let json = JSON(value)
                guard let jsonC = json["contacts"].array else {
                    return
                }
                for jsonC in jsonC {
                    if let people = People(json: jsonC) {
                        self.contact.append(people)
                    }
                }
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NotificationKey.didFetchSuccess, object: nil)
                }
            case .failure(let error):
                print(error)
            default:
                break
            }
        }
    }
}
