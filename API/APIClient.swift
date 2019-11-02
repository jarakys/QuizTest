//
//  APIClient.swift
//  iOS 12 Notifications
//
//  Created by Kirill on 01.11.2019.
//  Copyright © 2019 Kirill. All rights reserved.
//
import Alamofire
import Foundation
class APIClient {
    @discardableResult
    private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>)->Void) -> DataRequest {
        return AF.request(route).validate(statusCode: 200..<299)
                        .responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
                            if let data = try? response.result.get(){
                                debugPrint(data)
                                completion(.success(data))
                            } else if let error = response.error {
                                completion(.failure(error))
                            }
        }
    }
    
    static func login(email:String, password: String,complition:@escaping (Result<UserModel,AFError>)->Void) {
        performRequest(route: APIRouter.login(email: email, password: password), completion: complition)
    }
    
    static func register(name: String, email:String, password:String, complition:@escaping (Result<UserModel,AFError>)->Void) {
        performRequest(route: APIRouter.register(name: name, email: email, password: password), completion: complition)
    }
    
    static func getQuestions(startIndex: Int, complition:@escaping (Result<[QuestionModel],AFError>)->Void) {
        performRequest(route: APIRouter.questions(startIndex: startIndex), completion: complition) 
    }    
}
