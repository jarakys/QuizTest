//
//  Constants.swift
//  iOS 12 Notifications
//
//  Created by Kirill on 01.11.2019.
//  Copyright © 2019 Andrew Jaffee. All rights reserved.
//

import Foundation
struct K {
    struct ProductionServer {
        static let baseURL = "http://starov88-001-site9.itempurl.com/api"
    }
    
    struct APIParameterKey {
        static let password = "Password"
        static let phone = "Phone"
        static let name = "name"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
