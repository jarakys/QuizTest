//
//  CaseKeys.swift
//  iOS 12 Notifications
//
//  Created by Kirill on 02.11.2019.
//  Copyright © 2019 Andrew Jaffee. All rights reserved.
//

import Foundation

enum CaseKey: Int {
    case a
    case b
    case c
    case d
    
    func string() -> String {
        return String(describing: self)
    }
}
