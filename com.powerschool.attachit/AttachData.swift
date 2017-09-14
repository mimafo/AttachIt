//
//  AttachData.swift
//  com.powerschool.attachit
//
//  Created by Mike Folcher on 9/13/17.
//  Copyright © 2017 Mike Folcher. All rights reserved.
//

import Foundation

struct AttachData {
    
    private(set) var title: String
    private(set) var detail: String
    private(set) lazy var data = [String:String]()
    
    init(title: String, detail: String) {
        self.title = title
        self.detail = detail
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
    
}


