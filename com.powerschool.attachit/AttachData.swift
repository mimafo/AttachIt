//
//  AttachData.swift
//  com.powerschool.attachit
//
//  Created by Mike Folcher on 9/13/17.
//  Copyright © 2017 Mike Folcher. All rights reserved.
//

import Foundation

struct AttachData {
    
    private(set) var key: String
    private(set) var title: String
    private(set) var detail: String
    private(set) var data: [String:Any]?
    
    init(data: [String:Any]) {
        self.data = data
        var lKey = ""
        var lTitle = ""
        var lDetail = ""
        
        
        if (data.index(forKey: AttachKeys.Employee.key) != nil) {

            lKey = AttachData.anyToString(data[AttachKeys.Employee.key]!)
            lTitle = AttachData.anyToString(data[AttachKeys.Employee.title_one]) + ", " + AttachData.anyToString(data[AttachKeys.Employee.title_two])
            lDetail = AttachData.anyToString(data[AttachKeys.Employee.detail])
            
        } else if (data.index(forKey: AttachKeys.Vendor.key) != nil) {
            
            lKey = AttachData.anyToString(data[AttachKeys.Vendor.key]!)
            lTitle = AttachData.anyToString(data[AttachKeys.Vendor.title])
            lDetail = AttachData.anyToString(data[AttachKeys.Vendor.detail_one]) + ", " + AttachData.anyToString(data[AttachKeys.Vendor.detail_two])
            
        }  else if (data.index(forKey: AttachKeys.Purchase.key) != nil) {
            
            lKey = AttachData.anyToString(data[AttachKeys.Purchase.key]!)
            lTitle = AttachData.anyToString(data[AttachKeys.Purchase.title])
            lDetail = AttachData.anyToString(data[AttachKeys.Purchase.detail])
        }
        
        self.key = lKey
        self.detail = lDetail
        self.title = lTitle
    }
    
    init(title: String, detail: String) {
        self.title = title
        self.detail = detail
        self.key = "0"
    }
    
    static func dummyAttachData() -> [AttachData] {
        var list = [AttachData]()
        
        //Build Dummy Data
        list.append(AttachData(title: "Joe Adams", detail: "Springfield High School"))
        list.append(AttachData(title: "Bob Thompson", detail: "Forest Lake Elementary School"))
        list.append(AttachData(title: "Mike Johnson", detail: "East Allen Middle School"))
        list.append(AttachData(title: "Alice Cooper", detail: "Manaro High School"))
        list.append(AttachData(title: "Emily Brownstone", detail: "East Allen Middle School"))
        list.append(AttachData(title: "Adam Blumberg", detail: "Delco Area Middel School"))
        list.append(AttachData(title: "Richard Delman", detail: "Springfield High School"))
        list.append(AttachData(title: "Alex Rossman", detail: "Forest Lake Elementary School"))
        list.append(AttachData(title: "Ann Marie Johnston", detail: "Pleasantville Elementary School"))
        list.append(AttachData(title: "Ted Richards", detail: "Forest Lake Elementary School"))
        list.append(AttachData(title: "Ralph Timbler", detail: "Springfield High School"))
        list.append(AttachData(title: "Chris Albertson", detail: "Delco Area Middle School"))
        list.append(AttachData(title: "Sam Westwood", detail: "Deerview Elementary School"))
        list.append(AttachData(title: "Jane Doe", detail: "Springfield High School"))
        
        return list
    }
    
    static func anyToString(_ value: Any?) -> String! {
        if let s = value {
            let newValue: String! = "\(String(describing: s))"
            return newValue
        }
        return ""
    }
    
}

struct AttachKeys {
    struct Employee {
        static let key = "empl_no"
        static let title_one = "full_name"
        static let title_two = "building_name"
        static let detail = "column3"
    }
    struct Vendor {
        static let key = "vend_no"
        static let title = "ven_name"
        static let detail_one = "city_state"
        static let detail_two = "column3"
    }
    struct Purchase {
        static let key = "po_no"
        static let title = "po_no_text"
        static let detail = "po_date"
    }
}


