//
//  CameraTableView.swift
//  Partisan
//
//  Created by kkolontay on 5/10/16.
//  Copyright © 2016 kkolontay.test.com. All rights reserved.
//

import UIKit

class CameraTableView: UITableViewController {
     override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
    }
    
    @available(iOS 2.0, *)
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    @available(iOS 2.0, *)
     override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}
