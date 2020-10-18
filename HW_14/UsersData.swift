//
//  UsersData.swift
//  HW_14
//
//  Created by Максим Нечеперунко on 18.10.2020.
//

import Foundation

class UsersData {
    static let shared = UsersData()
    private let kUserNameKey = "UsersData.kUserNameKey"
    private let kUsersSurnameKey = "UsersData.kUsersSurnameKey"
    var userName: String? {
        set{UserDefaults.standard.set(newValue , forKey: kUserNameKey)}
        get{return UserDefaults.standard.string(forKey: kUserNameKey)}
    }
    var userSurname: String? {
        set{UserDefaults.standard.set(newValue, forKey: kUsersSurnameKey)}
        get{return UserDefaults.standard.string(forKey: kUsersSurnameKey)}
       
    }
}
