//
//  AppState.swift
//  AppGenius
//
//  Created by Eldiiar on 29/4/24.
//

import SwiftUI

class AppState: ObservableObject {
    
    @Published var projects = [Project]()
    
    private var networkManager: MainNetworkManagerProtocol
    
    init(networkManager: MainNetworkManagerProtocol = MainNetworkManager.shared){
        self.networkManager = networkManager
    }
    
    func getProjects() {
        networkManager.getProjects { response in
            self.projects = response
        } onError: { error in
            print(error.localizedDescription)
        }

    }
    
}
