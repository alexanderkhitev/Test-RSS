//
//  WebShowerViewController.swift
//  Test RSS
//
//  Created by Alexsander  on 3/24/16.
//  Copyright © 2016 Alexsander Khitev. All rights reserved.
//

import UIKit

class WebShowerViewController: UIViewController, UIWebViewDelegate {
    
    // MARK: - var and let
    var url: NSURL!
    
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
        print(url)
        let urlRequest = NSURLRequest(URL: url)
        webView.loadRequest(urlRequest)
        webView.delegate = self 
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
