//
//  ViewController.swift
//  com.powerschool.attachit
//
//  Created by Mike Folcher on 9/13/17.
//  Copyright © 2017 Mike Folcher. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //Outlets
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    //ViewController Functions/Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Action Handlers
    @IBAction func loginPressed(_ sender: UIButton) {
        //TO DO: Perform Username and password validation
        
        //Dismiss the login page
        self.dismiss(animated: true, completion: nil)
        
    }

}

