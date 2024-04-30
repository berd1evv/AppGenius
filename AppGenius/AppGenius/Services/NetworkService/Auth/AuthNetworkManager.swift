//
//  AuthNetworkManager.swift
//  AppGenius
//
//  Created by Eldiiar on 28/4/24.
//

import Foundation
import Moya
import Alamofire

protocol AuthNetworkManagerProtocol{
    func signIn(clientId: String, clientSecret: String, code: String, onSuccess: @escaping (SignInResponse) -> Void, onError: @escaping (APIError) -> Void)
}

class AuthNetworkManager{
    static let shared = AuthNetworkManager()
    private let provider: MoyaProvider<AuthService>
    private var handleResponse: HandleResponseProtocol
    private var apiService: AuthService?
    
    init() {
        provider = MoyaProvider<AuthService>(plugins: [NetworkLoggerPlugin()])
        handleResponse = HandleResponse()
    }
}

extension AuthNetworkManager: AuthNetworkManagerProtocol{
    func signIn(clientId: String, clientSecret: String, code: String, onSuccess: @escaping (SignInResponse) -> Void, onError: @escaping (APIError) -> Void){
        provider.request(.signIn(clientId: clientId, clientSecret: clientSecret, code: code)) { result in
            self.handleResponse.handleResponse(result: result, onSuccess: onSuccess, onError: onError)
        }
    }
}
