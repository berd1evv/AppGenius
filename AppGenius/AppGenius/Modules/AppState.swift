//
//  AppState.swift
//  AppGenius
//
//  Created by Eldiiar on 29/4/24.
//

import SwiftUI

class AppState: ObservableObject {
    
    @Published var projects = [Project]()
    @Published var inboxTasks = [Task]()
    @Published var inboxTaskId = ""
    
    private var networkManager: MainNetworkManagerProtocol
    
    init(networkManager: MainNetworkManagerProtocol = MainNetworkManager.shared){
        self.networkManager = networkManager
    }
    
    func getProjects() {
        networkManager.getProjects { response in
            if let project = response.first(where: { $0.isInbox}) {
                self.inboxTaskId = project.id
                self.getInboxTask(projectId: project.id)
            }
            self.projects = self.makeHierarchy(from: response)
        } onError: { error in
            print(error.localizedDescription)
        }

    }
    
    func createTask(content: String, description: String?, projectId: String? = nil, completion: @escaping () -> ()) {
        var id: String? = nil
        if projectId == nil {
            id = inboxTaskId
        } else {
            id = projectId
        }
        networkManager.createTask(content: content, description: description, projectId: id) { task in
            if self.inboxTaskId == task.projectId {
                self.inboxTasks.append(task)
            }
            completion()
        } onError: { error in
            print(error.localizedDescription)
        }

    }
    
    func getInboxTask(projectId: String) {
        networkManager.getTasks(projectId: projectId, sectionId: nil, filter: nil) { response in
            print("Tasks", response)
            self.inboxTasks = response
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
