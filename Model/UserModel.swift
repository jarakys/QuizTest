//
//  UserModel.swift
//  iOS 12 Notifications
//
//  Created by Dmitriy Chumakov on 9/11/19.
//  Copyright © 2019 Andrew Jaffee. All rights reserved.
//

import Foundation

struct UserModel : Codable, Storeable {
        
    let id: String
    let name, phone, token: String
    
    var storeData: Data? {
        let encoder = JSONEncoder()
        let encoded = try? encoder.encode(self)
        return encoded
    }
    
    init?(storeData: Data?) {
        guard let storeData = storeData else { return nil }
        let decoder = JSONDecoder()
        guard let decoded = try? decoder.decode(UserModel.self, from: storeData) else { return nil }
        self = decoded
    }
}

