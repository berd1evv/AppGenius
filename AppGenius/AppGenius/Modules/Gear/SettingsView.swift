//
//  SettingsView.swift
//  AppGenius
//
//  Created by Eldiiar on 30/4/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        Button {
            Storage.shared.setUserToken("")
        } label: {
            Text("Log Out")
                .font(.title)
        }

    }
}

#Preview {
    SettingsView()
}
