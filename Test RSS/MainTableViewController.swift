//
//  MainTableViewController.swift
//  Test RSS
//
//  Created by Alexsander  on 11/2/15.
//  Copyright © 2015 Alexsander Khitev. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire
import SafariServices

class MainTableViewController: UITableViewController, NSXMLParserDelegate, SFSafariViewControllerDelegate {

    // MARK: - Iboutlet 
    @IBOutlet weak var viewForImage: UIView!
    @IBOutlet weak var generalImageView: UIImageView!
    
    var parser: NSXMLParser!
    let notificationCenter = NSNotificationCenter.defaultCenter()
    let fileManager = NSFileManager.defaultManager()
    
    var foundCharacter = ""
    var currentElement = ""
    var dataXMLDictionary = [String : String]()
    var dictionaryArray = [[String : String]]()
    var checkDictionary = [[String : String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true
        let url = NSURL(string: "http://9to5mac.com/feed")!
//        let url = NSURL(string: "http://feeds.feedburner.com/appcoda")!
  
        parser = NSXMLParser(contentsOfURL: url)
        parser.delegate = self
        parser.parse()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1 ?? 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dictionaryArray.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MainTableViewCell
        let data = dictionaryArray[indexPath.row]
        let titleFile = data["title"]
        let dateFile = data["pubDate"]?.stringByReplacingOccurrencesOfString("+0000", withString: "\0")

        cell.titleLabel.text = titleFile
        cell.dateLabel.text = dateFile

        return cell
    }
    
    // MARK: - functions
    
    func parserDidStartDocument(parser: NSXMLParser) {
        print("parser start")
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        print("End parser document 777777")
        self.tableView.reloadData()
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
        
        let safariController = SFSafariViewController(URL: url!)
        safariController.delegate = self
        presentViewController(safariController, animated: true, completion: nil)
    }
}
