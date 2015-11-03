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

class MainTableViewController: UITableViewController, NSXMLParserDelegate {

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
        
        
//        let url = NSURL(string: "http://9to5mac.com/feed")!
//        let url = NSURL(string: "http://lenta.ru/rss")!
        let url = NSURL(string: "http://feeds.feedburner.com/appcoda")!
  
        parser = NSXMLParser(contentsOfURL: url)
        parser.delegate = self
        parser.parse()
        
        

        let megaURL = NSURL(string: "http://www.appcoda.com/building-rss-reader-using-uisplitviewcontroller-uipopoverviewcontroller/")!
        
        print(megaURL)
        

    
        
     
        Alamofire.request(.GET, megaURL).responseData { (data) -> Void in
            if data.result.isSuccess {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data.result.value!, options: NSJSONReadingOptions.AllowFragments) as! [String : AnyObject]
                    
                    
                    print("hello json")
                    print(json)
                } catch {
                    print("bye json")
                }
                print("is success")
                
                    
            } else {
                print("is failure")
            }
        }
        
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
        
//
        
        let data = dictionaryArray[indexPath.row]
        let titleFile = data["title"]
        let dateFile = data["pubDate"]?.stringByReplacingOccurrencesOfString("+0000", withString: "\0")
        
//        print(titleFile)

        

        
        
        

        cell.titleLabel.text = titleFile
        cell.dateLabel.text = dateFile
//        cell.imageURL?.image = image

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
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
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if currentElement == "title" || currentElement == "link" || currentElement == "pubDate" {
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
        presentViewController(safariController, animated: true, completion: nil)
        
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
