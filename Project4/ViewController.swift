//
//  ViewController.swift
//  Project4
//
//  Created by Sabrina Fletcher on 12/19/17.
//  Copyright © 2017 Sabrina Fletcher. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController,WKNavigationDelegate {
    
    var webView: WKWebView!
    var progressView: UIProgressView!
    var website: String?
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self //Delegation
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil) //#keyPath like #selector allows the compiler to check that your code is correct, that there actually exist an estimatedProgress property
        
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        progressView = UIProgressView(progressViewStyle: .default) //creates UIProgressView instance
        progressView.sizeToFit() //sets layout size to fit content
        let progressButton = UIBarButtonItem(customView: progressView) //wrap our UIProgressView into a UIBarButtonItem in order to place it on the toolbar.
        
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action:nil) //we create a new bar button item using a special system type, flexible space, no need for a target or action cause it can't be tapped
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload)) //creates the refresh button to be displayed on the toolbar
        toolbarItems = [progressButton,spacer,refresh] //array of the things on the toolbar
        navigationController?.isToolbarHidden = false //makes the toolbar shown
        
        let url = URL(string: "https://" + website!)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    /*
    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        for website in websites{
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url!.host{
            for website in websites{
                if host.range(of: website) != nil{
                    decisionHandler(.allow)
                    return
                }
            }
        }
        decisionHandler(.cancel)
    }
 
 */
    
    func openPage(action: UIAlertAction){
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

