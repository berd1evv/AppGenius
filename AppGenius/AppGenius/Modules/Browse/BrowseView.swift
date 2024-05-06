//
//  BrowseView.swift
//  AppGenius
//
//  Created by Eldiiar on 29/4/24.
//

import SwiftUI

struct BrowseView: View {
    @EnvironmentObject var appState: AppState
    @State private var isExpanded = true
    @State private var buttonTapped = false
    @State private var selectedProject: Project = Project()
    @State private var showSettings = false
    @State private var showManageProject = false
    @State private var isNewTask: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            List {
                Section(isExpanded: $isExpanded) {
                    OutlineGroup(appState.projects.filter { !$0.isInbox}, children: \.children) { project in
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
                    .onTapGesture {
                        showManageProject = true
                    }
                } header: {
                    HStack {
                        HStack {
                            Text("My Projects")
                                .font(.caption)
                            Image(systemName: "chevron.right")
                        }
                        .onTapGesture {
                            showManageProject = true
                        }
                        
                        Spacer()
                        Menu {
                            VStack {
                                Button {
                                    
                                } label: {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text("Add Project")
                                                .font(.headline)
                                            Text("Plan and assign tasks")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                        Image(systemName: "number")
                                    }
                                }
                            }
                        } label: {
                            Image(systemName: "plus")
                        }
                        Button {
                            withAnimation {
                                isExpanded.toggle()
                            }
                        } label: {
                            Image(systemName: "chevron.right")
                                .rotationEffect(.degrees(isExpanded ? 90 : 0))
                        }
                    }
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
        .onChange(of: isNewTask, {
            UIView.setAnimationsEnabled(false)
        })
        .fullScreenCover(isPresented: $isNewTask, content: {
            NewTaskView(isPresented: $isNewTask)
        })
        .sheet(isPresented: $showManageProject, content: {
            ManageProjectView()
        })
        .sheet(isPresented: $showSettings, content: {
            SettingsView()
        })
        .navigationDestination(isPresented: $buttonTapped) {
            ProjectView(project: selectedProject)
        }
    }
}
