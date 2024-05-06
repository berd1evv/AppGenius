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
    @State private var isNewTask: Bool = false
    @State private var editTask: Bool = false
    @State private var selectedTask: Task = Task()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            List {
                Section("Overdue") {
                    ForEach(viewModel.overdueTasks.indices, id: \.self) { index in
                        TaskView(task: viewModel.overdueTasks[index])
                            .onTapGesture {
                                selectedTask = viewModel.overdueTasks[index]
                                editTask = true
                            }
                    }
                    .onDelete {
                        viewModel.overdueTasks.remove(atOffsets: $0)}
                }
                Section("Today") {
                    ForEach(viewModel.todaysTasks.indices, id: \.self) { index in
                        TaskView(task: viewModel.todaysTasks[index])
                            .onTapGesture {
                                selectedTask = viewModel.todaysTasks[index]
                                editTask = true
                            }
                    }
                    .onDelete {
                        viewModel.todaysTasks.remove(atOffsets: $0)}
                }
            }
            Button(action: {
                isNewTask = true
            }, label: {
                ZStack {
                    Circle()
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                }
                
            })
            .frame(width: 50, height: 50, alignment: .bottomTrailing)
            .padding()
        
        }
        .onChange(of: isNewTask, {
            UIView.setAnimationsEnabled(false)
        })
        .fullScreenCover(isPresented: $isNewTask, content: {
            NewTaskView(isPresented: $isNewTask)
        })
        .sheet(isPresented: $editTask, content: {
            EditTaskView(task: $selectedTask)
                .presentationDragIndicator(.visible)
                .presentationDetents([.medium, .large])
        })
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
