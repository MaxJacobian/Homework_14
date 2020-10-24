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

    
    var getId = Int()
    var idMain = 0
    
    @IBAction func addTarget(_ sender: Any) {
    targetVC.append(Target.getTargetObject(id: idMain, task: targetTextField.text!, isPacked: false))
        idMain  += 1
        Persistance.shared.createTargetTask(target: targetVC)
        tableView.reloadData()
        targetTextField.text = ""
        
    }
    
    @IBAction func removeScreenTarget(_ sender: Any) {
        
       
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.targetVC = Persistance.shared.loadedData()
       
        
    }
}

extension ToDoListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return targetVC.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoList") as! ToDoListTableViewCell
        cell.targetLabel.text = "\(targetVC[indexPath.row].task)"
        cell.backgroundView = UIView()
        cell.backgroundView?.backgroundColor = .gray
        if targetVC[indexPath.row].isPacked == true{
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
       
        
        return cell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        Persistance.shared.updateItem(targ: targetVC[indexPath.row])
        tableView.reloadRows(at: [indexPath], with: .automatic)
      
    }
    func tableView(_ tableView: UITableView,
                     commit editingStyle: UITableViewCell.EditingStyle,
                     forRowAt indexPath: IndexPath){
        tableView.setEditing(true, animated: true)
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
    }
   
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        
        tableView.deselectRow(at: indexPath!, animated: false)
        
        let item = targetVC[indexPath!.row]
        let id = item.id
        Persistance.shared.removeTarget(idRemove: id)
        targetVC.remove(at: indexPath!.row)
        tableView.reloadData()
        
        
    }
 
}



