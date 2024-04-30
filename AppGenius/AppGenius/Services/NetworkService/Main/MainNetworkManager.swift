//
//  MainNetworkManager.swift
//  AppGenius
//
//  Created by Eldiiar on 29/4/24.
//

import Foundation
import Moya
import Alamofire

protocol MainNetworkManagerProtocol{
    func getProjects(onSuccess: @escaping ([Project]) -> Void, onError: @escaping (APIError) -> Void)
    func getTasks(projectId: String?, sectionId: String?, onSuccess: @escaping ([Task]) -> Void, onError: @escaping (APIError) -> Void)
}

class MainNetworkManager{
    static let shared = MainNetworkManager()
    private let provider: MoyaProvider<MainService>
    private var handleResponse: HandleResponseProtocol
    
    init() {
        provider = MoyaProvider<MainService>(plugins: [NetworkLoggerPlugin()])
        handleResponse = HandleResponse()
    }
}

extension MainNetworkManager: MainNetworkManagerProtocol{
    func getProjects(onSuccess: @escaping ([Project]) -> Void, onError: @escaping (APIError) -> Void){
        provider.request(.getProjects) { result in
            self.handleResponse.handleResponse(result: result, onSuccess: onSuccess, onError: onError)
        }
    }
    
    func getTasks(projectId: String?, sectionId: String?, onSuccess: @escaping ([Task]) -> Void, onError: @escaping (APIError) -> Void) {
        provider.request(.getTasks(projectId: projectId, sectionId: sectionId)) { result in
            self.handleResponse.handleResponse(result: result, onSuccess: onSuccess, onError: onError)
        }
    }
}
