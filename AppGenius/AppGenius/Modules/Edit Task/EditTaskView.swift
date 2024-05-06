//
//  EditTaskView.swift
//  AppGenius
//
//  Created by Eldiiar on 5/5/24.
//

import SwiftUI

struct EditTaskView: View {
    @Binding var task: Task
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .frame(width: 20, height: 20)
                Text(task.content.cleanedText())
                    .font(.title2)
                Spacer(minLength: 0)
            }
            
            if !task.description.isEmpty {
                HStack {
                    Image(systemName: "line.3.horizontal")
                        .frame(width: 20, height: 20)
                    Text(task.description)
                        .font(.title3)
                    Spacer()
                }
            }
            if let due = task.due {
                HStack {
                    Image(systemName: "calendar")
                        .frame(width: 20, height: 20)
                    Text(due.string)
                    Spacer()
                }
            }
            Spacer()
        }
        .padding()
        
    }
}
