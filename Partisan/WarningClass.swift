//
//  WarningClass.swift
//  Partisan
//
//  Created by kkolontay on 5/5/16.
//  Copyright © 2016 kkolontay.test.com. All rights reserved.
//

import UIKit

class WarningClass {

    class  func warning(messageCustomer: String, viewController: UIViewController) {
        dispatch_async(dispatch_get_main_queue(), {
        let alertController = UIAlertController(title: "Alert", message: messageCustomer, preferredStyle: UIAlertControllerStyle.Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        viewController.presentViewController(alertController, animated: true, completion: nil)
        })
    }
}