//
//  EditTaskView.swift
//  AppGenius
//
//  Created by Eldiiar on 5/5/24.
//

import SwiftUI

struct EditTaskView: View {
    var task: Task
    
    var body: some View {
        Text(task.content.cleanedText())
            .font(.title2)
        if !task.description.isEmpty {
            Text(task.description)
                .font(.caption)
        }
        if let due = task.due {
            Text(due.string)
        }
    }
}
