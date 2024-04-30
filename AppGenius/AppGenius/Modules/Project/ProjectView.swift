//
//  ProjectView.swift
//  AppGenius
//
//  Created by Eldiiar on 29/4/24.
//

import SwiftUI

struct ProjectView: View {
    var projectTitle: String
    @State private var todoItems = [
        TodoItem(title: "Task 1", description: "Description for task 1", isCompleted: false),
        TodoItem(title: "Task 2", description: nil, isCompleted: true),
        TodoItem(title: "Task 3", description: "Description for task 3", isCompleted: false)
    ]
    
    var body: some View {
        List(todoItems) { item in
            HStack {
                Image(systemName: item.isCompleted ? "circle.fill" : "circle")
                    .frame(width: 20, height: 20)
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.headline)
                    if let description = item.description {
                        Text(description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                Spacer()
            }
        }
        .navigationTitle(projectTitle)
        .navigationBarTitleDisplayMode(.large)
    }
}
