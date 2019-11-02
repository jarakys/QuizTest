//
//  Question+CoreDataProperties.swift
//  
//
//  Created by Kirill on 02.11.2019.
//
//

import Foundation
import CoreData


extension Question {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Question> {
        return NSFetchRequest<Question>(entityName: "Question")
    }

    @NSManaged public var answers: Answers?
    @NSManaged public var correctAnswerText: String?
    @NSManaged public var idQuestion: String?
    @NSManaged public var text: String?

}
