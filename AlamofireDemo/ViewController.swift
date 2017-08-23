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
    var contact: [People] = [] {
        willSet {
            self.contact = DataServices.shared.contact
        }
        didSet {
            guard contact.count > 0 else {
                return
            }
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNotification()
        DataServices.shared.requestJSONFromURL()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: NotificationKey.didFetchSuccess, object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    func handleNotification(_ notification: Notification) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        self.contact = DataServices.shared.contact
    }
    var url = "http://api.androidhive.info/contacts/"
    @IBAction func btnTapped(_ sender: UIBarButtonItem) {
        DataServices.shared.requestJSONFromURL()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contact.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = contact[indexPath.row].name
            cell.detailTextLabel?.text = contact[indexPath.row].phone?.mobile
        return cell
    }
}
