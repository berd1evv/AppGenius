//
//  TodayViewModel.swift
//  AppGenius
//
//  Created by Eldiiar on 30/4/24.
//

import Foundation

class TodayViewModel: ObservableObject {
    
    @Published var overdueTasks = [Task]()
    @Published var todaysTasks = [Task]()
    
    private var networkManager: MainNetworkManagerProtocol
    
    init(networkManager: MainNetworkManagerProtocol = MainNetworkManager.shared){
        self.networkManager = networkManager
        self.getTasksForToday()
    }
    
    
    func getTasksForToday() {
        networkManager.getTasks(projectId: nil, sectionId: nil, filter: "today|overdue") { response in
            print("Tasks", response)
            self.overdueTasks = response.filter { !self.isDateToday($0.due?.date ?? Date())}
            self.todaysTasks = response.filter { self.isDateToday($0.due?.date ?? Date())}
        } onError: { error in
            print(error.localizedDescription)
        }

    }
    
    func isDateToday(_ date: Date) -> Bool {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let otherDate = calendar.startOfDay(for: date)
        return today == otherDate
    }
}
