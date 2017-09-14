//
//  DataTableViewController.swift
//  com.powerschool.attachit
//
//  Created by Mike Folcher on 9/13/17.
//  Copyright © 2017 Mike Folcher. All rights reserved.
//

import UIKit

class DataTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //data properties
    var attachData = AttachData.dummyAttachData()
    var alertController: UIAlertController {
        let ac = UIAlertController(title: "Image Select", message: "Choose photo or camera?", preferredStyle: .actionSheet)
        let cameraButton = UIAlertAction(title: "Camera", style: .default, handler: { (action) -> Void in
            self.showSelectedOption(UIImagePickerControllerSourceType.camera)
        })
        let albumButton = UIAlertAction(title: "Album", style: .default, handler: { (action) -> Void in
            self.showSelectedOption(UIImagePickerControllerSourceType.photoLibrary)
        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(cameraButton)
        ac.addAction(albumButton)
        ac.addAction(cancelButton)
        
        return ac
    }
    
    //MARK: UIViewController functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //wire stuff up
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SubtitleCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //initialize the selectedImage to nil
        self.selectedImage = nil
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: UITableViewController Functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.attachData.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        
        
        if cell == self.tableView.dequeueReusableCell(withIdentifier: "SubtitleCell") {
        } else {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "SubtitleCell")
        }
        
        let realCell = cell!
        let data = self.attachData[indexPath.row]

        realCell.textLabel?.text = data.title
        realCell.detailTextLabel?.text = data.detail
        
        return realCell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = self.attachData[indexPath.row]
        self.selectedAttachData = data
    }
    
    //MARK: UIImagePickerControllerDelegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //Set the key string appropriately
        var keyString: String!
        if picker.allowsEditing {
            keyString = UIImagePickerControllerEditedImage
        } else {
            keyString = UIImagePickerControllerOriginalImage
        }
        
        if let image = info[keyString] as? UIImage {
            self.selectedImage = image
        }
        
        self.dismiss(animated: true, completion: {
            if self.selectedImage != nil {
                self.performSegue(withIdentifier: "ImageSegue", sender: self)
            }
        })
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Action Handlers
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        
        self.navigationController!.present(self.alertController, animated: true, completion: nil)
        
    }
    
    //MARK: Private Functions
    private func showSelectedOption(_ source: UIImagePickerControllerSourceType) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = source
        self.present(pickerController, animated: true, completion: nil)
        
    }

}