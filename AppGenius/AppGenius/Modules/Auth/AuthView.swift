//
//  AuthView.swift
//  AppGenius
//
//  Created by Eldiiar on 28/4/24.
//

import SwiftUI

struct AuthView: View {
    @State private var showWebView = false
    @StateObject private var viewModel: AuthViewModel = AuthViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                Text("Authorization")
                Button {
                    showWebView = true
                } label: {
                    Text("Tap to signin")
                }

            }
            .sheet(isPresented: $showWebView, content: {
                WebKitView(dismiss: {
                    showWebView = false
                    viewModel.signIn()
                }, url: "https://todoist.com/oauth/authorize?client_id=124481347ddb4a5499caea8c9b035384&scope=data:read,data:delete&state=secretstring")
            })
            .navigationDestination(isPresented: $viewModel.isSuccess) {
                ContentView()
            }
        }
    }
}
