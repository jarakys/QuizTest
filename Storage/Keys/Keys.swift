//
//  Keys.swift
//  iOS 12 Notifications
//
//  Created by Dmitriy Chumakov on 9/11/19.
//  Copyright © 2019 Andrew Jaffee. All rights reserved.
//

import Foundation
enum Keys : String, LocalStorageKeysProtocol {
    case User = "User"
    case intervalMin = "timeInterval"
    case minutes = "minutes"
    case seconds = "seconds"
    case AnswerTimeSync = "answerTimeSync"
    case currentQuestion = "currentQuestion"
    
    func string() -> String {
        self.rawValue
    }
    
}
