//
//  WebKitView.swift
//  AppGenius
//
//  Created by Eldiiar on 28/4/24.
//

import SwiftUI
import WebKit

struct WebKitView: View {
    let dismiss: () -> Void
    var url: String
    
    var body: some View {
        WebView(url: URL(string: url)!, dismiss: dismiss)
    }
}

struct WebView: UIViewRepresentable {
    let url: URL
    let dismiss: () -> Void
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(dismiss: dismiss)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        let dismiss: () -> Void
        
        init(dismiss: @escaping () -> Void) {
            self.dismiss = dismiss
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            // Handle page start loading event
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // Handle page finish loading event
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            decisionHandler(.allow)
            guard let url = navigationAction.request.url else { return }
            print(#function, url)
            if let queryItems = URLComponents(string: url.absoluteString)?.queryItems {
                for queryItem in queryItems {
                    if queryItem.name == "code" {
                        guard let code = queryItem.value else { return }
                        Storage.shared.setRegistrationId(code)
                        dismiss()
                    }
                }
            }
        }
    }
}

