//
//  ManageProjectView.swift
//  AppGenius
//
//  Created by Eldiiar on 30/4/24.
//

import SwiftUI

struct ManageProjectView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button("Cancel", role: .cancel) {
                    dismiss()
                }
                Spacer()
                Button(action: {
//                    showSettings = true
                }, label: {
                    Image(systemName: "plus")
                })
            }
            .padding()
            List {
                OutlineGroup(appState.projects.filter { !$0.isInbox }, children: \.children) { project in
                    HStack {
                        Image(systemName: "number")
                        Text(project.name)
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
    //                    selectedProject = project
    //                    buttonTapped.toggle()
                    }
                }

            }
        }
        .navigationTitle("My Projects")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ManageProjectView()
}
