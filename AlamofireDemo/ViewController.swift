//
//  ViewController.swift
//  AlamofireDemo
//
//  Created by Khuat Van Dung on 8/21/17.
//  Copyright © 2017 Khuat Van Dung. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var url = "http://api.apixu.com/v1/forecast.json?days=7&key=7042f000fa43421b98612223172606&q=hanoi"
    //    var url = "http://api.androidhive.info/contacts/"
    var arrRes = [[String:AnyObject]]() //Array of dictionary
    @IBAction func btnTapped(_ sender: UIBarButtonItem) {
        //                Alamofire.request(url).responseJSON { (responseData) -> Void in
        //                                if responseData.result.value != nil {
        //                                    let swiftyJsonVar = JSON(responseData.result.value!)
        //                                    print(swiftyJsonVar)
        //                                    if let resData = swiftyJsonVar["location"].arrayObject {
        //                                        self.arrRes = resData as! [[String:AnyObject]]
        //                                    }
        //                                    if self.arrRes.count > 0 {
        //                                        self.tableView.reloadData()
        //                                    }
        //                                }
        //                    }
       
        Alamofire.request(url).responseJSON { (responseData) -> Void in
            switch responseData.result {
            case .success(let value):
                let json = JSON(value)
                if let resData = json["forecast"]["forecastday"][0]["hour"].arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                }
                if self.arrRes.count > 0 {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        
        /* //response String
         Alamofire.request(url).responseString { (responseData) -> Void in
         if responseData.result.value != nil {
         let jsonString =  responseData.result.value!
         if let dataFromString = jsonString.data(using: .utf8, allowLossyConversion: false) {
         let json = JSON(data: dataFromString)
         print(json)
         if let resData = json["contacts"].arrayObject {
         self.arrRes = resData as! [[String:AnyObject]]
         }
         if self.arrRes.count > 0 {
         self.tableView.reloadData()
         }
         }
         }
         }
         */
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        var dict = arrRes[indexPath.row]
        cell.textLabel?.text = dict["time"] as? String
        cell.detailTextLabel?.text =  String(describing: dict["temp_c"]!)
        return cell
    }
}

