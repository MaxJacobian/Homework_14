//
//  ToDoListViewController.swift
//  HW_14
//
//  Created by Максим Нечеперунко on 18.10.2020.
//

import UIKit






class ToDoListViewController: UIViewController {
    
    var targetVC: [Target] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var targetTextField: UITextField!
    var targetId = 0
    
    @IBAction func addTarget(_ sender: Any) {
        
        targetId += 1
        targetVC.append(Target.getTargetObject(id: targetId, task: targetTextField.text!, isPacked: false))
        Persistance.shared.createTargetTask(target: targetVC)
        tableView.reloadData()
        targetTextField.text = ""
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.targetVC = Persistance.shared.loadedData()
       
        
    }
}

extension ToDoListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return targetVC.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoList") as! ToDoListTableViewCell
        cell.targetLabel.text = targetVC[indexPath.row].task
        return cell
    }
    
    
}



