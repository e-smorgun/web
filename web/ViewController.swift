//
//  ViewController.swift
//  web
//
//  Created by Evgeny on 27.06.22.
//

import Foundation
import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var textLabel: UITextField!
    @IBOutlet weak var webView: WKWebView!
    
    var history: [URL] = []
    var currentUrl: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: String("https://apple.com")) {
            let requst = URLRequest(url: url)
            webView.load(requst)
        }

        webView.navigationDelegate = self
        textLabel.text = currentUrl?.absoluteString
    }

    @IBAction func didTapBackButton() {
        print(history)
        if history.isEmpty == true {
            didTapCloseButton()
        } else {
        history.removeLast()
            if history.isEmpty == true {
                didTapCloseButton()
            } else {
                let requst = URLRequest(url: (history.last)!)
                webView.load(requst)
            }
        }
    }
    
    @IBAction func didTapGoButton() {
        if let url = URL(string: String(textLabel.text ?? "")) {
            let requst = URLRequest(url: url)
            webView.load(requst)
        }

        webView.navigationDelegate = self
    }
    
    @IBAction func didTapCloseButton() {
        if let url = URL(string: String("https://google.com")) {
            let requst = URLRequest(url: url)
            webView.load(requst)
        }

        webView.navigationDelegate = self
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

        if history.contains(where: {$0 == webView.url!}) {
           // it exists, do something
        } else {
            history.append(webView.url!)
        }
        currentUrl = history.first(where: {$0 == webView.url!})
    }
}

