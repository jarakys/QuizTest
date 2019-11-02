//
//  LocalStorageProtocol.swift
//  iOS 12 Notifications
//
//  Created by Kirill on 01.11.2019.
//  Copyright © 2019 Kirill. All rights reserved.
//

import Foundation
protocol LocalStorageProtocol {
    func value<T>(key: LocalStorageKeysProtocol) -> T?
    func write<T>(key: LocalStorageKeysProtocol, value: T?)
    func remove(key: LocalStorageKeysProtocol)
    
    func valueStoreable<T>(key: LocalStorageKeysProtocol) -> T? where T: Storeable
    func writeStoreable<T>(key: LocalStorageKeysProtocol, value: T?) where T: Storeable
}
