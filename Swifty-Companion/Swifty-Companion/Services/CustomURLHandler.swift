//
//  CustomURLHandler.swift
//  Swifty-Companion
//
//  Created by Joao Nascimento on 25.8.2023.
//

import OAuthSwift
import WebKit

class CustomURLHandler: NSObject, OAuthSwiftURLHandlerType {
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func handle(_ url: URL) {
        let webView = WKWebView(frame: viewController?.view.bounds ?? .zero)
        viewController?.view.addSubview(webView)
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func dismissWebViewController() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}

