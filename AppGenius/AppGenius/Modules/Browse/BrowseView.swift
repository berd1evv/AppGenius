//
//  BrowseView.swift
//  AppGenius
//
//  Created by Eldiiar on 29/4/24.
//

import SwiftUI

struct CustomDisclosureGroupStyle: DisclosureGroupStyle {
    @State var showsDisclosureIndicator: Bool

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            if showsDisclosureIndicator {
                Image(systemName: configuration.isExpanded ? "chevron.down" : "chevron.right")
                    .onTapGesture {
                        withAnimation {
                            configuration.isExpanded.toggle()
                        }
                    }
            }
        }
        .contentShape(Rectangle())
//        .onTapGesture {
//            withAnimation {
//                configuration.isExpanded.toggle()
//            }
//        }
    }
}

struct BrowseView: View {
    @EnvironmentObject var appState: AppState
    var data = ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"]
    @State private var isExpanded = false
    @State private var buttonTapped = false
    @State private var selectedProject: Project = Project()
    @State private var showSettings = false
    
    var body: some View {
        List {
            
            OutlineGroup(appState.projects, children: \.children) { project in
                HStack {
                    Image(systemName: "number")
                    Text(project.name)
                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedProject = project
                    buttonTapped.toggle()
                }
            }
            
            HStack {
                Image(systemName: "pencil")
                Text("Manage projects")
            }

        }
        .navigationTitle("Browse")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    showSettings = true
                }, label: {
                    Image(systemName: "gear")
                })
            }
        }
        .sheet(isPresented: $showSettings, content: {
            SettingsView()
        })
        .navigationDestination(isPresented: $buttonTapped) {
            ProjectView(project: selectedProject)
        }
    }
}

#Preview {
    BrowseView()
}
