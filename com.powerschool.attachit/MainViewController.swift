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
    let attachmentTypes = ["Employee", "Purchase Order", "Invoice", "Vendor"]
    
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
        return self.attachmentTypes.count
    }
    
    //MARK: Delegates
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.attachmentTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.currentAttachmentType = self.attachmentTypes[row]
    }
    
    
    
    
}
