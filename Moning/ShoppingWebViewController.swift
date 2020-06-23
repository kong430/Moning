//
//  ShoppingWebViewController.swift
//  Moning
//
//  Created by 이제인 on 2020/06/23.
//  Copyright © 2020 이제인. All rights reserved.
//

import UIKit
import WebKit

class ShoppingWebViewController: UIViewController, WKUIDelegate,WKNavigationDelegate {

    @IBOutlet weak var shoppingWebView: WKWebView!
    
    
    override func loadView() {
        super.loadView()
        shoppingWebView = WKWebView(frame: self.view.frame)
        shoppingWebView.uiDelegate = self
        shoppingWebView.navigationDelegate = self
        self.view = self.shoppingWebView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: Codination.tappedCodiUrl)
        let request = URLRequest(url: url!)
        shoppingWebView.load(request)
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    //confirm 처리
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String,
                 initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: {
            (action) in completionHandler(true) }))
        alertController.addAction(UIAlertAction(title: "취소", style: .default, handler: {
            (action) in completionHandler(false) }))
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    //confirm 처리2
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?,
                 initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping (String?) -> Void) {
        let alertController = UIAlertController(title: "", message: prompt, preferredStyle: .alert)
        alertController.addTextField { (textField) in textField.text = defaultText }
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in
            if let text = alertController.textFields?.first?.text {
                completionHandler(text)
                
            }
            else {
                completionHandler(defaultText)
                
            } }))
        alertController.addAction(UIAlertAction(title: "취소", style: .default, handler: { (action) in
            completionHandler(nil) }))
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    // href="_blank" 처리
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration,
                 for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
            
        }
        return nil
        
    }
    
    // 중복적으로 리로드 방지
    public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        webView.reload()
        
    }
}
