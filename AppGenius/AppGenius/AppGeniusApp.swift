//
//  AppGeniusApp.swift
//  AppGenius
//
//  Created by Eldiiar on 28/4/24.
//

import SwiftUI

@main
struct AppGeniusApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage(UserDefaultsStorage.userToken) private var userToken = ""
    @StateObject private var appState: AppState = AppState()
    
    var body: some Scene {
        WindowGroup {
            if userToken.isEmpty {
                AuthView()
            } else {
                mainViewScreen
            }
            
        }
    }
    
    private var mainViewScreen: some View {
        TabView {
            NavigationStack {
                TodayView()
                    .environmentObject(appState)
            }
            .tabItem {
                Label(
                    title: { Text("Today") },
                    icon: { Image(systemName: "calendar") }
                )
            }
            .tag(0)
            
            NavigationStack {
                InboxView()
                    .environmentObject(appState)
            }
            .tabItem {
                Label(
                    title: { Text("Inbox") },
                    icon: { Image(systemName: "tray") }
                )
            }
            .tag(1)
            
            NavigationStack {
                BrowseView()
                    .environmentObject(appState)
            }
            .tabItem {
                Label(
                    title: { Text("Browse") },
                    icon: { Image(systemName: "list.bullet") }
                )
            }
            .tag(2)
        }
        
    }
}
