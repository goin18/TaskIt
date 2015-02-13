//
//  ViewController.swift
//  TaskIt
//
//  Created by Marko Budal on 13/02/15.
//  Copyright (c) 2015 Marko Budal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var taskArray:[TaskModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        let date1 = Date.from(year: 2014, month: 02, day: 13)
        let date2 = Date.from(year: 2014, month: 02, day: 14)
        
        let task1 = TaskModel(task: "Ucenje Swift", subTask: "TAble", date: date1)
        let task2 = TaskModel(task: "UI - neki", subTask: "Bla", date: date2)
        
        taskArray = [task1, task2]
        
        self.tableView.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        func sortByDate(taskOne:TaskModel, taskTwo: TaskModel) -> Bool {
            return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
        }
        
        taskArray = taskArray.sorted(sortByDate)
        
        tableView.reloadData()
    }
    
    //PreperForSegue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showTaskDetail" {
            let detailVC: TaskDetailViewController = segue.destinationViewController as TaskDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            let thisTask = taskArray[indexPath!.row]
            detailVC.detailTaskModel = thisTask
            detailVC.mainVC = self
            
        } else if segue.identifier == "showTaskAdd" {
            let addTaskVC: AddTaskViewController = segue.destinationViewController as AddTaskViewController
            addTaskVC.mainVC = self
        }
    }
    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
        performSegueWithIdentifier("showTaskAdd", sender: self)
    }
    
    //UITableViewDataSorce
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return taskArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var cell:TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
        
        var taskDic = taskArray[indexPath.row]
        cell.taskLabel.text = taskDic.task
        cell.descriptionLabel.text = taskDic.subTask
        cell.dateLabel.text = Date.toString(date: taskDic.date)
        
        return cell
    }
    
    //UItableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Row: \(indexPath.row)")
        
        performSegueWithIdentifier("showTaskDetail", sender: self)
    }
    
    //Helpers
    


}

