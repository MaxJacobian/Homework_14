//
//  CDToDoListTableViewController.swift
//  HW_14
//
//  Created by Максим Нечеперунко on 23.10.2020.
//

import UIKit
import CoreData

class CDToDoListTableViewController: UITableViewController {
    
    

    var tasks: [Tasks] = []
    var id: Int32 = 1
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let fetchRequest: NSFetchRequest<Tasks> = Tasks.fetchRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        do {
            tasks = try context.fetch(fetchRequest)
          
        } catch let error as NSError {
            print(error.localizedDescription)
         }
    }
    
    @IBAction func addTask(_ sender: Any) {
        
        let alertController = UIAlertController(title: "New task", message: "Enter your task", preferredStyle: .alert)
        let saveTask = UIAlertAction(title: "Save", style: .default) {action in
            let tf = alertController.textFields?.first
            if let newTask = tf?.text {
                self.saveTask(id: self.id, target: newTask, isPacked: false)
                self.id += 1
                self.tableView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default){_ in}
        alertController.addTextField{_ in}
        alertController.addAction(saveTask)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        
    }
    func saveTask(id: Int32, target: String, isPacked: Bool){
        guard let entity = NSEntityDescription.entity(forEntityName: "Tasks", in: context) else {return}
        
        let taskObject = Tasks(entity: entity, insertInto: context)
        taskObject.target = target
        taskObject.id = id
        taskObject.isPacked = isPacked
        do {
            try context.save()
            tasks.append(taskObject)
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
        
        
    }
    func deleteTask(id: Int32){
        if let tasks = try? context.fetch(fetchRequest){
            for task in tasks {
                if id == task.id {
                    context.delete(task)
                    tableView.reloadData()
                }
            }
        }
        do {
            try context.save()
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
        tableView.reloadData()
        
    }
    func updateTask(taskCheck: Tasks){
        if let tasks = try? context.fetch(fetchRequest) {
            for task in tasks {
                if task === taskCheck {
                    task.isPacked = !task.isPacked
                }
            }
        }
        do {
            try context.save()
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
        tableView.reloadData()
    }
    
    
  

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row].target
        if tasks[indexPath.row].isPacked == true {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        updateTask(taskCheck: tasks[indexPath.row])
        tableView.reloadRows(at: [indexPath], with: .automatic)

    }
    override func tableView(_ tableView: UITableView,
                     commit editingStyle: UITableViewCell.EditingStyle,
                     forRowAt indexPath: IndexPath){
        tableView.setEditing(true, animated: true)
        tableView.reloadRows(at: [indexPath], with: .automatic)

    }

    override func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        tableView.deselectRow(at: indexPath!, animated: false)
        let task = tasks[indexPath!.row]
        let id = task.id
        deleteTask(id: id)
   }
}
