//
//  ProjectViewModel.swift
//  AppGenius
//
//  Created by Eldiiar on 30/4/24.
//

import SwiftUI

class ProjectViewModel: ObservableObject {
    
    @Published var sections = [Sections]()
    @Published var tasks = [Task]()

    private var networkManager: MainNetworkManagerProtocol

    init(networkManager: MainNetworkManagerProtocol = MainNetworkManager.shared){
        self.networkManager = networkManager
    }

    func getSections(projectId: String) {
        networkManager.getSections(projectId: projectId) { response in
            self.sections = response
            self.getTask(projectId: projectId)
        } onError: { error in
            print(error.localizedDescription)
        }

    }
    
    func getTask(projectId: String) {
        networkManager.getTasks(projectId: projectId, sectionId: nil, filter: nil) { response in
            print("Tasks", response)
            self.tasks = response
        } onError: { error in
            print(error.localizedDescription)
        }
    }
}
