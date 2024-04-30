//
//  AuthViewModel.swift
//  AppGenius
//
//  Created by Eldiiar on 28/4/24.
//

import SwiftUI

class AuthViewModel: ObservableObject {
    
    @Published var isSuccess = false
    
    private let networkManager: AuthNetworkManagerProtocol
    private let storage: StorageProtocol
    
    init(
        networkManager: AuthNetworkManagerProtocol = AuthNetworkManager.shared,
        storage: StorageProtocol = Storage.shared
    ){
        self.networkManager = networkManager
        self.storage = storage
    }
    
    func signIn() {
        networkManager.signIn(clientId: "124481347ddb4a5499caea8c9b035384", clientSecret: "7b78b89d1f254238911146420f75470c", code: Storage.shared.getRegistrationId()) { response in
            Storage.shared.setUserToken(response.accessToken)
//            self.isSuccess = true
            print("Success", response)
        } onError: { error in
            print("Error", error.localizedDescription)
        }

    }
}
