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
    
    var body: some View {
        List {
            ForEach(viewModel.tasks.filter { $0.sectionId == nil }, id: \.self) { project in
                TaskView(task: project)
            }
            ForEach(viewModel.sections, id: \.self) { section in
                Section(section.name, isExpanded: .constant(true)) {
                    ForEach(viewModel.tasks.filter { $0.sectionId == section.id}, id: \.self) { task in
                        TaskView(task: task)
                    }
                }
            }
        }
        .navigationTitle(project.name)
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            viewModel.getSections(projectId: project.id)
        }
    }
    
    @ViewBuilder
    func Task(_ task: Task) -> some View {
        
    }
}

struct TaskView: View {
    var task: Task
//    var onTap: ()
    
    var body: some View {
        HStack {
            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                .frame(width: 20, height: 20)
//                .onTapGesture {
//                    if let index = viewModel.tasks.firstIndex(where: { $0.id == task.id}) {
//                        viewModel.tasks[index].isCompleted.toggle()
//                    }
//                }
            VStack(alignment: .leading) {
                Text(task.content.cleanedText())
                    .font(.headline)
                if !task.description.isEmpty {
                    Text(task.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                if let due = task.due {
                    Text(due.string)
                        .font(.subheadline)
                        .foregroundStyle(!due.date.isPastDate() ? .black : .red)
                }
            }
            .contentShape(Rectangle())
            Spacer()
        }
    }
}
