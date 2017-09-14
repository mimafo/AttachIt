//
//  ImageViewController.swift
//  com.powerschool.attachit
//
//  Created by Mike Folcher on 9/13/17.
//  Copyright © 2017 Mike Folcher. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = self.selectedImage {
            self.imageView.image = image
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func annotatePressed(_ sender: Any) {
    }
    
    @IBAction func undoPressed(_ sender: Any) {
    }
    
    @IBAction func savePressed(_ sender: Any) {
    }

}
