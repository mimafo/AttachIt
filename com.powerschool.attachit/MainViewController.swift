//
//  MainViewController.swift
//  com.powerschool.attachit
//
//  Created by Mike Folcher on 9/13/17.
//  Copyright © 2017 Mike Folcher. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //Class variables
    //let attachmentTypes = ["Employee", "Purchase Order", "Invoice", "Vendor"]
    var attachmentTypes: [String]?
    
    //Outlets
    @IBOutlet weak var attachTypePicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let username = self.username, username != "" {
            //Do stuff with the username
        } else {
            self.performSegue(withIdentifier: "LoginSegue", sender: self)
        }
        
        AttachAPIContoller().getAttachTypes { (types) in
            performUIUpdatesOnMain {
                self.attachmentTypes = types
                self.attachTypePicker.reloadAllComponents()
            }
        }
        
        self.attachTypePicker.dataSource = self
        self.attachTypePicker.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let types = self.attachmentTypes {
            return types.count
        }
        return 0
    }
    
    //MARK: Delegates
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let types = self.attachmentTypes {
            return types[row]
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let types = self.attachmentTypes {
            if !types.isEmpty {
                self.currentAttachmentType = types[row]
            }
        }
    }
    
    //MARK: Action Handlers
    @IBAction func nextPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "DataSegue", sender: self)
    }
    
}
