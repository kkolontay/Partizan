//
//  CameraItems.swift
//  Partisan
//
//  Created by kkolontay on 5/10/16.
//  Copyright © 2016 kkolontay.test.com. All rights reserved.
//

import UIKit

protocol RenewDataDelegate: class {
    func reloadDataTable()
}

class CameraItems: NSObject {
    private var itemsCamera: [Camera]?
     var jsonData: Dictionary<String, AnyObject>?
    override init() {
        super.init()
        itemsCamera = [Camera]()
    }
    
}
extension CameraItems: FetchResultUserRequest {
     func checkedResults(result: Dictionary<String, AnyObject>) {
        jsonData = result
    }
}