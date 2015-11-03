//
//  XMLParser.swift
//  Test RSS
//
//  Created by Alexsander  on 11/2/15.
//  Copyright © 2015 Alexsander Khitev. All rights reserved.
//

import UIKit
import Foundation

class XMLParser: NSObject, NSXMLParserDelegate {
    
    var arrayParse = [[String: String]]()
    var currentDataDictionary = [String : String]()
    var currentElement = ""
    var foundCharacter = ""
    let notificationCenter = NSNotificationCenter.defaultCenter()
    
    var delegate = NSXMLParser().delegate
    
    func startParsingWithContentOfURL(rssURL: NSURL) {
        let parser = NSXMLParser(contentsOfURL: rssURL)!
//        print("parse start")
        parser.delegate = self
        parser.parse()
        print(parser.parse())
    }
    
    
    func parserDidStartDocument(parser: NSXMLParser) {
//        print("did start document \(parser)")
    }
    
    
    func parserDidEndDocument(parser: NSXMLParser) {
        print("did end document \(parser)")
        print("array end \(arrayParse, arrayParse.count)")
    }
 
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        currentElement = elementName
        print("did start element")
        print(currentElement)
    }
   
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if currentElement == "title" || currentElement == "pubDate" || currentElement == "link" {
            foundCharacter += string
            print("foundCharacter")
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        print("did end element")
            if elementName == "link" {
//                foundCharacter = (foundCharacter as NSString).substringToIndex(3)
                
                currentDataDictionary[currentElement] = foundCharacter
                
                foundCharacter = ""
                
                arrayParse.append(currentDataDictionary)
                
                
            }
    }
    

    
    

}
