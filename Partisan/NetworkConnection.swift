//
//  NetworkConnection.swift
//  Partisan
//
//  Created by kkolontay on 5/5/16.
//  Copyright © 2016 kkolontay.test.com. All rights reserved.
//

import UIKit

enum Request: String {
    case kye = "111f69f077175ac67b88a8cdd18e1122"
    case hostName = "https://developer.partizancloud.com:8443/"
    case updateUserDevice = "rest/updateUserDevice"
    case securityLogin = "rest/securityLogin?"
    case getUserDevices = "restProtected/getUserDevices"
    case emptyBody = "json={}"
    
}
enum ResponseError: Int {
    case notError0 = 0
    case timeExpered101 = 101
    case unknowError408 = 408
    var description: String {
        switch self {
        case notError0:
            return "Request successfull."
        case timeExpered101:
            return "Session time expired."
        case unknowError408:
            return "Unknown error."
            
        }
    }
}
enum  ResponseUserRequest: Int {
    case userNoError0 = 0
    case userNotActive202 = 202
    case userDoesNotExist204 = 204
    case userBadCredential205 = 205
    case userUnknowError208 = 208
    case userInvalidKey209 = 209
    var description: String {
        switch self {
        case .userNoError0:
            return "Request successfull."
        case .userNotActive202:
            return "The user has not activated the account."
        case .userDoesNotExist204:
            return "User does not exist."
        case .userBadCredential205:
            return "Bad credentials."
        case .userUnknowError208:
            return "Unknow error."
        case .userInvalidKey209:
            return "Invalid key for client api."
            
        }
    }
}

protocol FetchResultUserRequest: class {
    func checkedResults(result: Dictionary<String, AnyObject>)
}

class NetworkConnection: NSObject {
    private var responseData: String?
    weak var delegate: FetchResultUserRequest?
    
    func fetchURl(typeURLRequest:String, stringRequest: String? = nil)  {
        
        let requestString = String(format: "%@%@", Request.hostName.rawValue, typeURLRequest).stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        let request = NSMutableURLRequest(URL: NSURL( string: requestString!)!)
        request.HTTPMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
        if stringRequest != nil {
            request.HTTPBody = stringRequest?.dataUsingEncoding(NSUTF8StringEncoding)
        }
        let dataRespond = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil  else {
                print("Error: \(error)")
                return
            }
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
                print("your status code \(httpStatus.statusCode)")
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.responseData = NSString(data: data!, encoding: NSUTF8StringEncoding) as? String
                self.parseJSON(self.responseData!)
                
            })
        }
        dataRespond.resume()
    }
    
    func parseJSON(jsonString: String) -> [String: AnyObject]? {
        guard let data = jsonString.dataUsingEncoding(NSUTF8StringEncoding) else
        {
            return nil
        }
        do {
            let result = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String: AnyObject]
            delegate?.checkedResults(result!)
            return result
        } catch {
            print("JSON error: \(error)")
            return nil
        }
        
    }
    
}