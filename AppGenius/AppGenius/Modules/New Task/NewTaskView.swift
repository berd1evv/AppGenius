//
//  NewTaskView.swift
//  AppGenius
//
//  Created by Eldiiar on 5/5/24.
//

import SwiftUI

struct NewTaskView: View {
    @EnvironmentObject var appState: AppState
    @Binding var isPresented: Bool
    @FocusState var isFocused: Bool
    @State private var content: String = ""
    @State private var description: String = ""
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(isPresented ? .black.opacity(0.5) : Color.clear)
                .opacity(isPresented ? 0.5 : 0)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        isPresented = false
                    }
                }
            VStack {
                Spacer()
                VStack {
                    TextField("e.g., Renew gym every may 1", text: $content)
                        .focused($isFocused)
                    TextField("Description", text: $description)
                    HStack {
                        Spacer()
                        Button(action: {
                            appState.createTask(content: content, description: description) {
                                withAnimation {
                                    isPresented = false
                                }
                            }
                        }, label: {
                            Text("Create")
                        })
                    }
                }
                .padding()
                .background(.white)
//                .clipShape(RoundedCorner(radius: 16, corners: [.topLeft, .topRight]))
            }
        }
        .background(FullScreenCoverBackgroundRemovalView())
        .onAppear {
            if !UIView.areAnimationsEnabled {
                UIView.setAnimationsEnabled(true)
            }
            isFocused = true
        }
        .onDisappear {
//            userDismissCallback(dismissSource ?? .binding)
            if !UIView.areAnimationsEnabled {
                UIView.setAnimationsEnabled(true)
            }
        }
    }
}


private struct FullScreenCoverBackgroundRemovalView: UIViewRepresentable {

    private class BackgroundRemovalView: UIView {

        override func didMoveToWindow() {
            super.didMoveToWindow()

            superview?.superview?.backgroundColor = .clear
        }

    }

    func makeUIView(context: Context) -> UIView {
        return BackgroundRemovalView()
    }

    func updateUIView(_ uiView: UIView, context: Context) {}

}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
