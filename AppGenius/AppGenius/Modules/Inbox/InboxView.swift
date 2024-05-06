//
//  InboxView.swift
//  AppGenius
//
//  Created by Eldiiar on 29/4/24.
//

import SwiftUI

struct InboxView: View {
    @StateObject var viewModel: InboxViewModel = InboxViewModel()
    @EnvironmentObject var appState: AppState
    @State private var isNewTask: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            List {
                ForEach(appState.inboxTasks.indices, id: \.self) { index in
                    TaskView(task: appState.inboxTasks[index])
                }
                .onDelete {appState.inboxTasks.remove(atOffsets: $0)}
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
        .navigationTitle("Inbox")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    InboxView()
}
