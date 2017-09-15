//
//  NetworkClient.swift
//  com.powerschool.attachit
//
//  Created by Mike Folcher on 9/14/17.
//  Copyright © 2017 Mike Folcher. All rights reserved.
//

import Foundation

class NetworkClient: NSObject {
    
    //MARK: Properties
    var session = URLSession.shared
    internal var offset = 0
    
    // MARK: Constants
    enum ErrorCatagory: String {
        case NetworkError = "Network Error"
        case InvalidResponseCode = "Invalid response code"
        case EmptyResponse = "No response from the service"
        case MalformedResponse = "Malformed response received"
    }
    static let ErrorCatagoryKey = "ErrorCatagory"
    
    //MARK: Generic request processing methods
    internal func executeRequest(request: URLRequest, domain: String, completionHandler: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        let task = self.session.dataTask(with: request as URLRequest) { data, response, error in
            
            func sendError(error: String, errorCatagory: ErrorCatagory) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error, NetworkClient.ErrorCatagoryKey : errorCatagory.rawValue ]
                completionHandler(nil, NSError(domain: domain, code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError(error: "There was an error with your request: \(String(describing: error))", errorCatagory: ErrorCatagory.NetworkError)
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError(error: "Your request returned a status code other than 2xx!",errorCatagory: ErrorCatagory.InvalidResponseCode)
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError(error: "No data was returned by the request!",errorCatagory: ErrorCatagory.EmptyResponse)
                return
            }
            
            //let newData = data.subdata(in: Range(self.offset, data.count - self.offset)) /* subset response data! */
            let newData = data
            
            /* Parse the data and use the data (happens in completion handler) */
            self.convertDataWithCompletionHandler(data: newData, completionHandlerForConvertData: completionHandler)
        }
        
        /* Initiate request */
        task.resume()
        
        return task
        
    }
    
    // given raw JSON, return a usable Foundation object
    internal func convertDataWithCompletionHandler(data: Data, completionHandlerForConvertData: (_ result: AnyObject?, _ error: NSError?) -> Void) {
        
        var parsedResult: Any!
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments)
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'",
                NetworkClient.ErrorCatagoryKey : NetworkClient.ErrorCatagory.MalformedResponse.rawValue]
            completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
        completionHandlerForConvertData(parsedResult as AnyObject, nil)
    }
    
    //MARK: Convenience Methods
    internal func buildURLPath(scheme: String, host: String, path: String, pathList: [String]?, queryList: [String:String]?) -> URL {
        
        let components = NSURLComponents()
        components.scheme = scheme
        components.host = host
        var path = path
        if let pathList = pathList {
            for subpath in pathList {
                path += subpath
            }
        }
        components.path = path
        
        if let queryList = queryList {
            components.queryItems = [URLQueryItem]() as [URLQueryItem]
            for (key,value) in queryList {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                components.queryItems!.append(queryItem as URLQueryItem)
            }
        }
        
        return components.url! as URL
        
    }
    
    
    
}
