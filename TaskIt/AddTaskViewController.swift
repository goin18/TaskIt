//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Marko Budal on 13/02/15.
//  Copyright (c) 2015 Marko Budal. All rights reserved.
//

import UIKit
import CoreData

class AddTaskViewController: UIViewController {
    
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
        
        let appDelegete = (UIApplication.sharedApplication().delegate as AppDelegate)
        let managedObjectContext = appDelegete.managedObjectContext
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: managedObjectContext!)
        let taskModel = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)

        taskModel.task = taskTextField.text
        taskModel.subtask = subTaskTextField.text
        taskModel.date = dueDatePicker.date
        taskModel.completed = false
        
        appDelegete.saveContext()
        
        //izpis
        var request = NSFetchRequest(entityName: "TaskModel")
        var error:NSError? = nil
        var results:NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
        
        for res in results{
            println(res)
        }
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
