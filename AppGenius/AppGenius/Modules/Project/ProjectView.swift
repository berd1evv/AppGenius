//
//  ProjectView.swift
//  AppGenius
//
//  Created by Eldiiar on 29/4/24.
//

import SwiftUI

struct ProjectView: View {
    var project: Project
    @StateObject private var viewModel: ProjectViewModel = ProjectViewModel()
    @State private var todoItems = [
        TodoItem(title: "Task 1", description: "Description for task 1", isCompleted: false),
        TodoItem(title: "Task 2", description: nil, isCompleted: true),
        TodoItem(title: "Task 3", description: "Description for task 3", isCompleted: false)
    ]
    
    var body: some View {
        List {
            ForEach(viewModel.project.indices, id: \.self) { index in
                HStack {
                    Image(systemName: "circle")
                        .frame(width: 20, height: 20)
                    VStack(alignment: .leading) {
                        Text(viewModel.project[index].content.cleanedText())
                            .font(.headline)
                        if !viewModel.project[index].description.isEmpty {
                            Text(viewModel.project[index].description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                }
            }
        }
        .navigationTitle(project.name)
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            viewModel.getTask(projectId: project.id)
        }
    }
}
