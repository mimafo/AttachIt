//
//  AttachAPIController.swift
//  com.powerschool.attachit
//
//  Created by Mike Folcher on 9/14/17.
//  Copyright © 2017 Mike Folcher. All rights reserved.
//

import Foundation

class AttachAPIContoller : NetworkClient {
    
    
    let attachTypeURL = "http://bth-trumbbra-d.bethlehem.sungardps.lcl:3000/categories"
    
    //MARK: Build request endpoints
    func getAttachTypes(completionHandler: @escaping (_ types: [String]?) -> Void) {
        
        var request = URLRequest(url: URL(string:self.attachTypeURL)!)
        
        //Set request values for POST
        request.httpMethod = "GET"
        //request.addValue("application/json", forHTTPHeaderField: "Accept")
        //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //return self.executeRequest(request, domain: "getCatagories", completionHandler:
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
    
}
