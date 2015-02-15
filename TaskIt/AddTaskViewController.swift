//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Marko Budal on 13/02/15.
//  Copyright (c) 2015 Marko Budal. All rights reserved.
//

import UIKit
import CoreData

protocol AddTaskViewControllerDelegate {
    func addTask(message: String)
    func addTaskCanceled(message: String)
}

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subTaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    var delegate: AddTaskViewControllerDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
           self.delegate.addTaskCanceled("Task was not added")
        })
    }

    @IBAction func addTaskButtonTapped(sender: UIButton) {
        
        let appDelegete = (UIApplication.sharedApplication().delegate as AppDelegate)
        let managedObjectContext = appDelegete.managedObjectContext
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: managedObjectContext!)
        let taskModel = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)

        
        if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitalizeTaskKey) == true {
            taskModel.task = taskTextField.text.capitalizedString
        }else {
            taskModel.task = taskTextField.text
        }
        
        if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCompleteNewTodoKey) == true {
            taskModel.completed = true
        }else {
            taskModel.completed = false
        }
        
        taskModel.subtask = subTaskTextField.text
        taskModel.date = dueDatePicker.date
        
        
        appDelegete.saveContext()
        
        //izpis
        var request = NSFetchRequest(entityName: "TaskModel")
        var error:NSError? = nil
        var results:NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
        
        for res in results{
            println(res)
        }
        
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            self.delegate.addTask("Task Added")
        })
        
    }
}
