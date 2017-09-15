//
//  AttachAPIController.swift
//  com.powerschool.attachit
//
//  Created by Mike Folcher on 9/14/17.
//  Copyright © 2017 Mike Folcher. All rights reserved.
//

import Foundation

class AttachAPIContoller : NetworkClient {
    
    //let attachTypeURL = "http://bth-trumbbra-d.bethlehem.sungardps.lcl:3000/categories"
    let attachTypeURL = "https://efpwf51aws.efinanceplus.demo.powerschool.com/eFP5.1/Hackathon/attachtype.json"
    let employeeURL = "https://efpwf51aws.efinanceplus.demo.powerschool.com/eFP5.1/Hackathon/employees.json"
    let vendorURL = "https://efpwf51aws.efinanceplus.demo.powerschool.com/eFP5.1/Hackathon/vendors.json"
    let purchaseURL = "https://efpwf51aws.efinanceplus.demo.powerschool.com/eFP5.1/Hackathon/purchase.json"
    
    
    //MARK: Build request endpoints
    func getAttachTypes(completionHandler: @escaping (_ types: [String]?) -> Void) {
        
        var request = URLRequest(url: URL(string:self.attachTypeURL)!)
        
        //Set request values for POST
        request.httpMethod = "GET"

        let task = self.executeRequest(request: request, domain: "getCategories") { (results, error) in
            
            guard let attachTypeList = results as? [AnyObject] else {
                completionHandler(nil)
                return
            }
            var attachTypes = [String]()
            
            for attachType in attachTypeList {
                if let attachType = attachType as? [String:String] {
                    attachTypes.append(attachType["attach_id"]!)
                    print("Attach ID: \(String(describing: attachType["attach_id"]))")
                }
            }
            completionHandler(attachTypes)
            
        }
        print("Task state is \(task.state)")

        
    }
    
    func getAttachDataList(attachType: String, completionHandler: @escaping (_ dataList: [AttachData]?) -> Void) {
        
        var getUrl = self.employeeURL
        if attachType.contains("EMPLOYEE") {
            getUrl = self.employeeURL
        } else if attachType.contains("VENDOR") {
            getUrl = self.vendorURL
        } else if attachType == "PO" {
            getUrl = self.purchaseURL
        }
        
        var request = URLRequest(url: URL(string:getUrl)!)
        
        //Set request values for POST
        request.httpMethod = "GET"
        
        let task = self.executeRequest(request: request, domain: "getData") { (results, error) in
            
            guard let responseList = results as? [AnyObject] else {
                completionHandler(nil)
                return
            }
            var attachData = [AttachData]()
            
            for attachStuff in responseList {
                if let attachStuff = attachStuff as? [String:Any] {
                    attachData.append(AttachData(data: attachStuff))
                }
            }
            completionHandler(attachData)
            
        }
        print("Task state is \(task.state)")
        
        
    }
    

    
}
