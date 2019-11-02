//
//  Answer.swift
//  iOS 12 Notifications
//
//  Created by Kirill on 02.11.2019.
//  Copyright © 2019 Andrew Jaffee. All rights reserved.
//

import Foundation

public class Answers: NSObject, NSCoding {
    
    public var answers:[AnswerDatabaseModel] = []
    
    enum Key: String {
        case answers = "answers"
    }
    
    init(answers: [AnswerDatabaseModel]) {
        self.answers = answers
    }
    
    
    public func encode(with coder: NSCoder) {
        coder.encode(answers, forKey: Key.answers.rawValue)
    }
    
    public required convenience init?(coder: NSCoder) {
        let mAnswers = coder.decodeObject(forKey: Key.answers.rawValue) as! [AnswerDatabaseModel]
        self.init(answers: mAnswers)
    }
    
    
}
