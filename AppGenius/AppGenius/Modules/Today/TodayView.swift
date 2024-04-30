//
//  TodayView.swift
//  AppGenius
//
//  Created by Eldiiar on 29/4/24.
//

import SwiftUI

struct TodayView: View {
    @StateObject private var viewModel: TodayViewModel = TodayViewModel()
    @EnvironmentObject var appState: AppState
    @State private var todoItems = [
        TodoItem(title: "Task 1", description: "Description for task 1", isCompleted: false),
        TodoItem(title: "Task 2", description: nil, isCompleted: true),
        TodoItem(title: "Task 3", description: "Description for task 3", isCompleted: false)
    ]
    var body: some View {
        List {
            ForEach(viewModel.todaysTasks.indices, id: \.self) { index in
                HStack {
                    Image(systemName: "circle")
                        .frame(width: 20, height: 20)
                    VStack(alignment: .leading) {
                        Text(viewModel.todaysTasks[index].content.cleanedText())
                            .font(.headline)
                        if !viewModel.todaysTasks[index].description.isEmpty {
                            Text(viewModel.todaysTasks[index].description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                }
            }
        }
        .onAppear {
            appState.getProjects()
        }
        .navigationTitle("Today")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    TodayView()
}
