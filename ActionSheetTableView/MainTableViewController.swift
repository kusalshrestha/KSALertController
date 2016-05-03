//
//  MainTableViewController.swift
//  ActionSheetTableView
//
//  Created by Kusal Shrestha on 5/2/16.
//  Copyright © 2016 Kusal Shrestha. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    func popAction(cell: UITableViewCell) {
        let alertView = KSAlertView()
        alertView.showDialog { (date) in
            if date != nil {
                cell.textLabel?.text = String(date!)
            } else {
                cell.textLabel?.text = "Date not selected"
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath)

        cell.textLabel?.text = String(indexPath.row)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.popAction(tableView.cellForRowAtIndexPath(indexPath)!)
    }
    
}
