//
//  VKLoginController.swift
//  vKontakte
//
//  Created by Andrew on 15/08/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation
import WebKit

class VKLoginController: UIViewController {
    
    @IBOutlet var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    @IBAction func unwinSegue(unwindSegue: UIStoryboardSegue){
        // при нажатии на крестик
        loadComponents()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadComponents()
    }
    
    fileprivate func loadComponents() {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "oauth.vk.com"
        components.path = "/authorize"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: "7097950"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.92")
        ]
        
        let request = URLRequest(url: components.url!)
        webView.load(request)
    }
    

}

extension VKLoginController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment else { decisionHandler(.allow); return }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        print(params)
        
        let sessions = Sessions.self
        
        
        guard let token = params["access_token"],
            let userIdString = params["user_id"],
            let _ = Int(userIdString) else {
                decisionHandler(.allow)
                return
        }
        sessions.shared.token = token
        sessions.shared.userId = userIdString
        
        //        Session.shared.token = token
        //         performSegue(withIdentifier:"")
        
        NetworkService.loadGroups(token: sessions.shared.token)
        
        performSegue(withIdentifier: "showTabBarContollers", sender: nil)
        
        decisionHandler(.cancel)
    }
}
