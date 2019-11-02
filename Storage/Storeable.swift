//
//  Storeable.swift
//  iOS 12 Notifications
//
//  Created by Kirill on 01.11.2019.
//  Copyright © 2019 Andrew Jaffee. All rights reserved.
//

import Foundation
protocol Storeable {
    var storeData: Data? { get }
    init?(storeData: Data?)
}
