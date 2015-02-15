//
//  SettingsViewController.swift
//  TaskIt
//
//  Created by Marko Budal on 14/02/15.
//  Copyright (c) 2015 Marko Budal. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var capitalizeTableView: UITableView!
    @IBOutlet weak var completeNewTableView: UITableView!
    @IBOutlet weak var versionLabel: UILabel!
    
    let kVersionNumber = "1.0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.capitalizeTableView.delegate = self
        self.capitalizeTableView.dataSource = self
        self.capitalizeTableView.scrollEnabled = false
        
        completeNewTableView.delegate = self
        completeNewTableView.dataSource = self
        completeNewTableView.scrollEnabled = false
        
        self.title = "Settings"
        versionLabel.text = kVersionNumber
        
        var doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("doneButtonButtonItemPressed:"))
        self.navigationItem.leftBarButtonItem = doneButton
        
    }
    
    func doneButtonButtonItemPressed(barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // UITableViewDataSorce
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == self.capitalizeTableView{
            var capitalizedCell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("capitalizeCell") as UITableViewCell
            
            if indexPath.row == 0 {
                capitalizedCell.textLabel?.text = "No do not Capitalize"
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitalizeTaskKey) == false {
                    capitalizedCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                } else {
                    capitalizedCell.accessoryType = UITableViewCellAccessoryType.None
                }
            } else {
                capitalizedCell.textLabel?.text = "Yes Capitalize!"
                
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitalizeTaskKey) == true {
                    capitalizedCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                } else {
                    capitalizedCell.accessoryType = UITableViewCellAccessoryType.None
                }
            }
            return capitalizedCell
        } else {
            var completeNewCell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("completeNewTodoCell") as UITableViewCell
            
            if indexPath.row == 0 {
                completeNewCell.textLabel?.text = "Do not complete Task"
                
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCompleteNewTodoKey) == false {
                    completeNewCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }else {
                    completeNewCell.accessoryType = UITableViewCellAccessoryType.None
                }
            }
            else {
                completeNewCell.textLabel?.text = "CompleteTask"
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCompleteNewTodoKey) == true {
                    completeNewCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                } else {
                    completeNewCell.accessoryType = UITableViewCellAccessoryType.None
                }
            }
            return completeNewCell
        
        }

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == self.capitalizeTableView {
            return "Capitalized New Task?"
        } else {
            return "Complete New Task?"
        }
    }
    
    // UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if tableView == self.capitalizeTableView {
            if indexPath.row == 0 {
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: kShouldCapitalizeTaskKey)
            }else {
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: kShouldCapitalizeTaskKey)
            }
        } else {
            if indexPath.row == 0 {
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: kShouldCompleteNewTodoKey)
            } else {
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: kShouldCompleteNewTodoKey)
            }
        }
        NSUserDefaults.standardUserDefaults().synchronize()
        tableView.reloadData()
    }
    
}
