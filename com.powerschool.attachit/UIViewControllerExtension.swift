//
//  UIViewControllerExtension.swift
//  com.powerschool.attachit
//
//  Created by Mike Folcher on 9/13/17.
//  Copyright © 2017 Mike Folcher. All rights reserved.
//

import UIKit

extension UIViewController {
    
    //MARK: Readonly properties
    var appDelegate: AppDelegate {
        return (UIApplication.shared.delegate as! AppDelegate)
    }
    var username: String? {
        return self.appDelegate.username
    }
    
    var selectedAttachData: AttachData? {
        get {
            return self.appDelegate.selectedAttachData
        }
        set {
            self.appDelegate.selectedAttachData = newValue
        }
    }
    
    var currentAttachmentType: String? {
        get {
            return self.appDelegate.currentAttachmentType
        }
        set {
            self.appDelegate.currentAttachmentType = newValue
        }
    }
    
    var selectedImage: UIImage? {
        get {
            return self.appDelegate.selectedImage
        }
        set {
            self.appDelegate.selectedImage = newValue
        }
    }
    
}
