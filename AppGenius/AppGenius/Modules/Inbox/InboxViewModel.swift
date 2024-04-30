//
//  InboxViewModel.swift
//  AppGenius
//
//  Created by Eldiiar on 29/4/24.
//

import SwiftUI

class InboxViewModel: ObservableObject {
    
    @Published var inboxTasks = [Task]()
    
    private var networkManager: MainNetworkManagerProtocol
    
    init(networkManager: MainNetworkManagerProtocol = MainNetworkManager.shared){
        self.networkManager = networkManager
    }
    
    
    func getTask(projectId: String) {
        networkManager.getTasks(projectId: projectId, sectionId: nil) { response in
            print("Tasks", response)
            self.inboxTasks = response
        } onError: { error in
            print(error.localizedDescription)
        }

    }
}
