//
//  Question+CoreDataClass.swift
//  
//
//  Created by Kirill on 02.11.2019.
//
//

import Foundation
import CoreData

@objc(Question)
public class Question: NSManagedObject {
    convenience init() {
       self.init(entity: CoreDataManager.instance.entityForName(entityName: "Question"), insertInto: CoreDataManager.instance.managedObjectContext)
    }
}
