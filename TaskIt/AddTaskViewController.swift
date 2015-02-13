//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Marko Budal on 13/02/15.
//  Copyright (c) 2015 Marko Budal. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    var mainVC: ViewController!
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subTaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func addTaskButtonTapped(sender: UIButton) {
        
        var task = TaskModel(task: taskTextField.text, subTask: subTaskTextField.text, date: dueDatePicker.date)

        mainVC.taskArray.append(task)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
