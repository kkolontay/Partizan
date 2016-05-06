//
//  UserInfo.swift
//  Partisan
//
//  Created by kkolontay on 5/5/16.
//  Copyright © 2016 kkolontay.test.com. All rights reserved.
//

import UIKit

class UserInfo: NSObject {
    private var emailUser: String?
    private var passwordUser: String?
    private var rememberUser: Bool?
    private var keyUser: String?
    private weak var viewController: UIViewController?
    
    init(viewControllerScreen: UIViewController) {
        super.init()
        keyUser = Request.kye.rawValue
        self.viewController = viewControllerScreen
    }
    
    var email: String {  set{
        
        if  validEmail(newValue) {
            emailUser = newValue
        }
        else {
            WarningClass.warning("Wrong e-mail's format", viewController: viewController!)
        }
        }
        get {
            return emailUser!
        }
    }

    var password: String {
        set {
            passwordUser = newValue
        }
        get {
            return passwordUser!
        }
    }
    var remember: Bool {
        set {
            rememberUser = newValue
        }
        get {
            return rememberUser!
        }
    }
    func validEmail(emailString: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluateWithObject(emailString)
       }
    func dataForRequest() -> String {
        let request = String(format: "json={\"email\":\"%@\",\"password\":\"%@\",\"remember_me\":%@,\"client_key\":\"%@\"}", emailUser!, passwordUser!, (rememberUser?.description)!, keyUser!)
        let requestUserValid = String(format: "%@%@%@", Request.hostName.rawValue, Request.securityLogin.rawValue, request.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
        return requestUserValid
    }
   
}
