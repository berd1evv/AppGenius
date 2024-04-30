//
//  InboxView.swift
//  AppGenius
//
//  Created by Eldiiar on 29/4/24.
//

import SwiftUI

struct TodoItem: Identifiable {
    var id = UUID()
    var title: String
    var description: String?
    var isCompleted: Bool
}

struct InboxView: View {
    @StateObject var viewModel: InboxViewModel = InboxViewModel()
    @EnvironmentObject var appState: AppState

    var body: some View {
        List {
            ForEach(viewModel.inboxTasks.indices, id: \.self) { index in
                HStack {
                    Image(systemName: "circle")
                        .frame(width: 20, height: 20)
                    VStack(alignment: .leading) {
                        Text(cleanedText(viewModel.inboxTasks[index].content))
                            .font(.headline)
                        if !viewModel.inboxTasks[index].description.isEmpty {
                            Text(viewModel.inboxTasks[index].description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                }
            }
        }
        .onAppear {
            if let project = appState.projects.first(where: { $0.isInbox}) {
                viewModel.getTask(projectId: project.id)
            }
        }
        .navigationTitle("Inbox")
        .navigationBarTitleDisplayMode(.large)
    }
    
    func cleanedText(_ text: String) -> String {
        var cleanedText = text
        // Remove content inside parentheses including the parentheses themselves
        cleanedText = cleanedText.replacingOccurrences(of: "\\(.*?\\)", with: "", options: .regularExpression)
        // Remove square brackets and the content inside them
        cleanedText = cleanedText.replacingOccurrences(of: "[", with: "")
        cleanedText = cleanedText.replacingOccurrences(of: "]", with: "")
        return cleanedText
    }
}

#Preview {
    InboxView()
}
