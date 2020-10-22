//
//  ViewController.swift
//  HW_14
//
//  Created by Максим Нечеперунко on 18.10.2020.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    

    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var nameTextfield: UITextField!
    
    
    @IBOutlet weak var surnameTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text =  UsersData.shared.userName
        surnameLabel.text = UsersData.shared.userSurname
        
        print("\(String(describing: UsersData.shared.userName) ) \(String(describing: UsersData.shared.userSurname))")
       
    }
    
    @IBAction func submitButton(_ sender: Any) {
        UsersData.shared.userName = nameTextfield.text!
        UsersData.shared.userSurname = surnameTextfield.text!
        nameLabel.text =  UsersData.shared.userName
        surnameLabel.text = UsersData.shared.userSurname
        
    }
    

}

