//
//  APIRouter.swift
//  iOS 12 Notifications
//
//  Created by Kirill on 01.11.2019.
//

import Foundation
import Alamofire

enum APIRouter : URLRequestConvertible {
    
    case login(email:String, password: String)
    case register(name: String, email: String, password: String)
    case questions(startIndex: Int)
    //case statistic(
    
    private var method: HTTPMethod {
        switch self {
        case .login, .register:
            return .post
        case .questions:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .login:
            return "/account/authenticate"
        case .register:
            return "/account/registration"
        case .questions(let startIndex):
            return "/Questions?page=\(startIndex)"
        }
        
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .login(let email, let password):
            return [K.APIParameterKey.phone: email, K.APIParameterKey.password: password]
        case .register(let name, let email, let password):
            return [K.APIParameterKey.name: name,K.APIParameterKey.phone: email, K.APIParameterKey.password: password]
        case .questions:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = K.ProductionServer.baseURL + path
        let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        let endURL = URL(string: encoded)
        var urlRequest = URLRequest(url: endURL!)
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                debugPrint(urlRequest.httpBody)
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }
    
}
