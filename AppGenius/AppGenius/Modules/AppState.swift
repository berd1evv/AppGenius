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
            self.projects = self.makeHierarchy(from: response)
        } onError: { error in
            print(error.localizedDescription)
        }

    }
    
    func makeHierarchy(from projects: [Project]) -> [Project] {
        var rootProjects = [Project]()
        for project in projects {
            if let parentId = project.parentId{
                if let index = rootProjects.firstIndex(where: { $0.id == parentId}) {
                    if rootProjects[index].children == nil {
                        rootProjects[index].children = []
                    }
                    rootProjects[index].children?.append(project)
                }
            } else {
                rootProjects.append(project)
            }
        }
        return rootProjects
    }

}
