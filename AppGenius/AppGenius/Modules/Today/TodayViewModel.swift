//
//  TodayViewModel.swift
//  AppGenius
//
//  Created by Eldiiar on 30/4/24.
//

import Foundation

class TodayViewModel: ObservableObject {
    
    @Published var todaysTasks = [Task]()
    
    private var networkManager: MainNetworkManagerProtocol
    
    init(networkManager: MainNetworkManagerProtocol = MainNetworkManager.shared){
        self.networkManager = networkManager
        self.getTasksForToday()
    }
    
    
    func getTasksForToday() {
        networkManager.getTasks(projectId: nil, sectionId: nil, filter: "today|overdue") { response in
            print("Tasks", response)
            self.todaysTasks = response
        } onError: { error in
            print(error.localizedDescription)
        }

    }
}
