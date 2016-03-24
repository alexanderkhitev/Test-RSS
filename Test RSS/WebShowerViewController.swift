//
//  WebShowerViewController.swift
//  Test RSS
//
//  Created by Alexsander  on 3/24/16.
//  Copyright © 2016 Alexsander Khitev. All rights reserved.
//

import UIKit
import MBProgressHUD

class WebShowerViewController: UIViewController {
    
    // MARK: - var and let
    var url: NSURL!
    private var progress: MBProgressHUD!
    // MARK: - IBOutlets
    @IBOutlet weak var webView: UIWebView!
    
    // MARK: - Lificycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setUpWebView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - web functions
    private func setUpWebView() {
        progress = MBProgressHUD.showHUDAddedTo(webView, animated: true)
        progress.removeFromSuperViewOnHide = true
        let urlRequest = NSURLRequest(URL: url)
        webView.loadRequest(urlRequest)
        webView.delegate = self
    }
}

// MARK: - UIWebViewDelegate functions
extension WebShowerViewController: UIWebViewDelegate {
    
    func webViewDidFinishLoad(webView: UIWebView) {
        progress.hide(true)
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        progress.hide(true)
        guard let _error = error else { return }
        print(_error.localizedDescription, _error.userInfo)
        let alertController = UIAlertController(title: "Произошла ошибка", message: _error.localizedDescription, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action) in
            self.navigationController?.popToRootViewControllerAnimated(true)
        }))
        presentViewController(alertController, animated: true, completion: nil)
    }
}
