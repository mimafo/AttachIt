//
//  DataTableViewController.swift
//  com.powerschool.attachit
//
//  Created by Mike Folcher on 9/13/17.
//  Copyright © 2017 Mike Folcher. All rights reserved.
//

import UIKit

class DataTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //Outlets
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    //data properties
    //var attachData = AttachData.dummyAttachData()
    var attachData: [AttachData]?
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
    
    var selectedCell: UITableViewCell?
    
    //MARK: UIViewController functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //wire stuff up
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SubtitleCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //initialize the selectedImage to nil
        self.selectedImage = nil
        self.addButton.isEnabled = false
        
        //Network calls
        if let attachType = self.currentAttachmentType {
            AttachAPIContoller().getAttachDataList(attachType: attachType, completionHandler: { (dataList) in
                performUIUpdatesOnMain {
                    if let list = dataList {
                        self.attachData = list
                        self.tableView.reloadData()
                    }
                }
            })
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let cell = self.selectedCell {
            cell.accessoryType = .none
            self.addButton.isEnabled = false
            self.selectedCell = nil
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: UITableViewController Functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = self.attachData {
            return list.count
        }
        return 0
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
        if let list = self.attachData {
            let data = list[indexPath.row]
            realCell.textLabel?.text = data.title
            realCell.detailTextLabel?.text = data.detail
        }
        
        return realCell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let list = self.attachData {
            let data = list[indexPath.row]
            self.selectedAttachData = data
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.accessoryType = .checkmark
                if let oldCell = self.selectedCell {
                    oldCell.accessoryType = .none
                }
                self.selectedCell = cell
                self.addButton.isEnabled = true
            }
        }
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
        
        if self.selectedCell == nil {
            return
        }
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
