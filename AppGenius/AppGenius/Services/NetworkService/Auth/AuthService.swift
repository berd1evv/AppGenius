//
//  AuthService.swift
//  AppGenius
//
//  Created by Eldiiar on 28/4/24.
//

import Foundation
import UIKit
import Moya
import Alamofire

enum AuthService{
    case signIn(clientId: String, clientSecret: String, code: String)
}

extension AuthService: TargetType{
    var baseURL: URL {
        return URL(string: EndPoints.shared.authURL)!
    }
    
    var path: String {
        switch self {
        case .signIn: return "oauth/access_token"
        }
    }
    
    var method: Moya.Method {
        switch self{
        case .signIn: return .post
        }
    }
    
    var sampleData: Data { Data() }
    
    var task: Moya.Task {
        switch self{
        case .signIn(let clientId, let clientSecret, let code):
            let params: [String: Any] = [
                "client_id": clientId,
                "client_secret": clientSecret,
                "code": code
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-type": "application/json"]
        }
    }
}
