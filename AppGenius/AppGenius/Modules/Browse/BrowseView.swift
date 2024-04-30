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
    var data = ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"]
    @State private var isExpanded = false
    @State private var buttonTapped = false
    @State private var selectedProject = ""
    @State private var showSettings = false
    
    var body: some View {
        List {
            DisclosureGroup(isExpanded: $isExpanded) {
                ForEach(data, id: \.self){ listItem in
                    HStack {
                        Text("Sub Item \(listItem)")
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedProject = "Sub Item \(listItem)"
                        buttonTapped.toggle()
                    }
                }
            } label: {
                HStack {
                    Image(systemName: "number")
                    Text("Home 🏡")
                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedProject = "Home 🏡"
                    buttonTapped.toggle()
                }
            }
//            .disclosureGroupStyle(CustomDisclosureGroupStyle(showsDisclosureIndicator: true))
            
            
            
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
            ProjectView(projectTitle: selectedProject)
        }
    }
}

#Preview {
    BrowseView()
}
