//
//  Tasks+CoreDataProperties.swift
//  HW_14
//
//  Created by Максим Нечеперунко on 25.10.2020.
//
//

import Foundation
import CoreData


extension Tasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tasks> {
        return NSFetchRequest<Tasks>(entityName: "Tasks")
    }

    @NSManaged public var id: Int32
    @NSManaged public var isPacked: Bool
    @NSManaged public var target: String?
    
    
}

extension Tasks : Identifiable {

}
