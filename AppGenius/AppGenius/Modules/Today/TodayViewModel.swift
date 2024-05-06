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
            self.overdueTasks = response.filter { !($0.due?.date.isDateToday() ?? false)}
            self.todaysTasks = response.filter { $0.due?.date.isDateToday() ?? false}
        } onError: { error in
            print(error.localizedDescription)
        }

    }
    
    
}

extension Date {
    func isDateToday() -> Bool {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let otherDate = calendar.startOfDay(for: self)
        return today == otherDate
    }
    
    func isPastDate() -> Bool {
        guard !self.isDateToday() else { return false }
        let now = Date()
        return self < now // Check if the date is earlier than now
    }
}
