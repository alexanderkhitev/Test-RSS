//
//  MainTableViewController.swift
//  Test RSS
//
//  Created by Alexsander  on 11/2/15.
//  Copyright © 2015 Alexsander Khitev. All rights reserved.
//

import UIKit
import Alamofire
import SafariServices
import MBProgressHUD

class MainTableViewController: UITableViewController, NSXMLParserDelegate, SFSafariViewControllerDelegate {

    // MARK: - IBOutlet
    private var progress: MBProgressHUD!
    private var parser: NSXMLParser!
    
    private var foundCharacter = ""
    private var currentElement = ""
    private var dataXMLDictionary = [String : String]()
    private var dictionaryArray = [[String : String]]()
//    private var checkDictionary = [[String : String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true
        progress = MBProgressHUD.showHUDAddedTo(view, animated: true)
        progress.removeFromSuperViewOnHide = true
        setUpParser()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1 ?? 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictionaryArray.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MainTableViewCell
        let data = dictionaryArray[indexPath.row]
        print(data)
        let titleFile = data["title"]
        let dateFile = data["pubDate"]?.stringByReplacingOccurrencesOfString("+0000", withString: "\0")
        cell.titleLabel.text = titleFile
        cell.dateLabel.text = dateFile

        return cell
    }
    
    // MARK: - functions
    
    func parserDidStartDocument(parser: NSXMLParser) {
        
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        self.tableView.reloadData()
        progress.hide(true)
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        currentElement = elementName
//        print(currentElement)
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if currentElement == "title" || currentElement == "link" || currentElement == "image" || currentElement == "pubDate" {
            foundCharacter += string
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        dataXMLDictionary[currentElement] = foundCharacter
        
        foundCharacter = ""
        
        if currentElement == "pubDate" {
            dictionaryArray.append(dataXMLDictionary)
        }
    }
 
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print(parseError.localizedDescription)
    }

    func parser(parser: NSXMLParser, validationErrorOccurred validationError: NSError) {
        print(validationError.localizedDescription)
    }
    
    // MARK: - Navigation
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: .None)
        let currentNews = dictionaryArray[indexPath.row]
        print(currentNews)
        
        let link = currentNews["link"]!
        
        let linkString = (link as NSString).substringFromIndex(3)
     
        let url = NSURL(string: linkString)
 
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let webShowerController = mainStoryboard.instantiateViewControllerWithIdentifier("WebShowerViewController") as! WebShowerViewController
        webShowerController.url = url
        showViewController(webShowerController, sender: self)
    }
    
    // MARK: - functions
    private func setUpParser() {
        guard let url = NSURL(string: "http://appleinsider.ru/feed") else { return }
        parser = NSXMLParser(contentsOfURL: url)
        parser.delegate = self
        parser.parse()
    }
 
}
