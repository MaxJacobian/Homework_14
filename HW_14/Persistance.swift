//
//  Persistance.swift
//  HW_14
//
//  Created by Максим Нечеперунко on 18.10.2020.
//

import Foundation
import RealmSwift


class Target: Object{
    @objc dynamic var id = Int()
    @objc dynamic var task = String()
    @objc dynamic var isPacked = false
    static func getTargetObject(id: Int, task: String, isPacked: Bool)-> Target{
        let target = Target()
        target.id = id
        target.task = task
        target.isPacked = isPacked
       
        return target
    }
    

}

class Persistance {
    static let shared = Persistance()
    let relam = try! Realm()
    var storage: [Target] = []
    func createTargetTask(target:[Target]){
        for targ in target {
            try! relam.write(){
                relam.add(targ)
            }
        }
        
    }
    func loadedData() ->[Target]{
        for targ in relam.objects(Target.self){
            storage.append(targ)
        }
        return storage
    }
}
