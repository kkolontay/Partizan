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
    case hostName = "https://api.partizancloud.com:8443/"
    case updateUserDevice = "rest/updateUserDevice?"
    case securityLogin = "rest/securityLogin?"
    case getUserDevices = "restProtected/getUserDevices?"

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
    enum  ResopnseUserRequest: Int {
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


class NetworkConnection: NSObject {
    
    func fetchURl(stringRequest: String) -> NSURL {
        return NSURL(string: stringRequest)!
    }
    
    func encodingURL(url: NSURL) -> String? {
        do {
            return try String(contentsOfURL: url, encoding: NSUTF8StringEncoding)
        } catch {
            print("dowload error:\(error)")
            return nil
        }
    }
    func parseJSON(jsonString: String) -> [String: AnyObject]? {
        guard let data = jsonString.dataUsingEncoding(NSUTF8StringEncoding) else
        {
            return nil
        }
        do {
            return try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String: AnyObject]
        } catch {
            print("JSON error: \(error)")
            return nil
        }
        
    }
}