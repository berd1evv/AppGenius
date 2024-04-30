//
//  ProjectViewModel.swift
//  AppGenius
//
//  Created by Eldiiar on 30/4/24.
//

import SwiftUI

class ProjectViewModel: ObservableObject {
    
    @Published var project = [Task]()

    private var networkManager: MainNetworkManagerProtocol

    init(networkManager: MainNetworkManagerProtocol = MainNetworkManager.shared){
        self.networkManager = networkManager
    }


    func getTask(projectId: String) {
        networkManager.getTasks(projectId: projectId, sectionId: nil, filter: nil) { response in
            print("Tasks", response)
            self.project = response
        } onError: { error in
            print(error.localizedDescription)
        }

    }
}
