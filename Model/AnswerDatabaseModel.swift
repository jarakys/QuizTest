//
//  AnswerDatabaseModel.swift
//  iOS 12 Notifications
//
//  Created by Kirill on 02.11.2019.
//  Copyright © 2019 Andrew Jaffee. All rights reserved.
//

import Foundation

public class AnswerDatabaseModel : NSObject, NSCoding {
    
    public var key: String
    public var text: String
    
    enum Key:String {
        case key = "key"
        case text = "text"
    }
    
    public init(key: String, text: String) {
        self.key = key
        self.text = text
    }
    
    
    public func encode(with coder: NSCoder) {
        coder.encode(key, forKey: Key.key.rawValue)
        coder.encode(text, forKey: Key.text.rawValue)
    }
    
    public required convenience init?(coder: NSCoder) {
        let mKey = coder.decodeObject(forKey: Key.key.rawValue)
        let mText = coder.decodeObject(forKey: Key.text.rawValue)
        self.init(key: mKey as! String, text: mText as! String)
    }
    
    
}
