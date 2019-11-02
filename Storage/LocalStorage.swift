//
//  LocalStorage.swift
//  iOS 12 Notifications
//
//  Created by Kirill on 01.11.2019.
//  Copyright © 2019 Andrew Jaffee. All rights reserved.
//

import Foundation
class LocalStorage: LocalStorageProtocol {
    
    private static let userDefaults = UserDefaults.init(suiteName: "group.notificationQuiz.com")!
    
    init() {
        LocalStorage.userDefaults.register(defaults: [Keys.minutes.string():1])
        LocalStorage.userDefaults.register(defaults: [Keys.seconds.string():1])
    }
    
    
    func value<T>(key: LocalStorageKeysProtocol) -> T? {
        return LocalStorage.userDefaults.object(forKey: key.rawValue) as? T
    }
    
    func write<T>(key: LocalStorageKeysProtocol, value: T?) {
        LocalStorage.userDefaults.set(value, forKey: key.rawValue)
    }
    
    func remove(key: LocalStorageKeysProtocol) {
        LocalStorage.userDefaults.set(nil, forKey: key.rawValue)
    }
    
    func valueStoreable<T>(key: LocalStorageKeysProtocol) -> T? where T: Storeable {
        let data: Data? = LocalStorage.userDefaults.data(forKey: key.rawValue)
        return T(storeData: data)
    }
    
    func writeStoreable<T>(key: LocalStorageKeysProtocol, value: T?) where T: Storeable {
        LocalStorage.userDefaults.set(value?.storeData, forKey: key.rawValue)
    }
}
