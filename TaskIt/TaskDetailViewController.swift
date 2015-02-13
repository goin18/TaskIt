//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by Marko Budal on 13/02/15.
//  Copyright (c) 2015 Marko Budal. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {

    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subTaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    var detailTaskModel: TaskModel!
    var mainVC: ViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.taskTextField.text = detailTaskModel.task
        self.subTaskTextField.text = detailTaskModel.subTask
        self.dueDatePicker.date = detailTaskModel.date
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func doneBarButtonPressed(sender: UIBarButtonItem) {
        
        var task = TaskModel(task: self.taskTextField.text, subTask: subTaskTextField.text, date: dueDatePicker.date)
        mainVC.taskArray[mainVC.tableView.indexPathForSelectedRow()!.row] = task

        self.navigationController?.popViewControllerAnimated(true)
    }
}
