//
//  AttachTypeViewController.swift
//  com.powerschool.attachit
//
//  Created by Mike Folcher on 9/14/17.
//  Copyright © 2017 Mike Folcher. All rights reserved.
//

import UIKit

class AttachTypeViewController: UITableViewController, UINavigationControllerDelegate {

    //Class variables
    let staticAttachmentTypes = ["Employee", "Purchase Order", "Invoice", "Vendor"]
    var attachmentTypes: [String]?
    
    //MARK: UIViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let username = self.username, username != "" {
            //Do stuff with the username
        } else {
            self.performSegue(withIdentifier: "LoginSegue", sender: self)
        }
        
        self.currentAttachmentType = ""
        self.navigationController?.title = "Attachment Types"
        self.attachmentTypes = self.staticAttachmentTypes
        
        AttachAPIContoller().getAttachTypes { (types) in
            performUIUpdatesOnMain {
                
                if let list = types {
                    if !list.isEmpty {
                        self.attachmentTypes = types
                        self.tableView.reloadData()
                    }
                }
            }
        }
        
        //wire stuff up
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITableViewController Functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let types = self.attachmentTypes {
            return types.count
        }
        return 0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        
        
        if cell == self.tableView.dequeueReusableCell(withIdentifier: "Cell") {
        } else {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        }
        let realCell = cell!
        
        if let types = self.attachmentTypes {
            
            let attachName = types[indexPath.row]
            realCell.textLabel?.text = attachName
            
        }
        
        return realCell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let types = self.attachmentTypes {
            let attachName = types[indexPath.row]
            self.currentAttachmentType = attachName
            self.performSegue(withIdentifier: "DataSegue", sender: self)
        }
    }
    
    
}
