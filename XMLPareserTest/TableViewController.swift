//
//  TableViewController.swift
//  XMLPareserTest
//
//  Created by Juergen Schwoediauer on 19.11.17.
//  Copyright © 2017 Juergen Schwoediauer. All rights reserved.
//

// helpful information
// https://www.youtube.com/watch?v=bF9cEcte0-E


import UIKit

class TableViewController: UIViewController, XMLParserDelegate {
    
    
    var eName: String = String()
    var BeginSection = String()
    var EndSection = String()
    var Season = String()
    var Background = String()
    var aspDate = String()
    var aspText = String()
    var aspImage = String()
    let WebContent = true   //toggle reading from WebURL or local file in Xcode project
    
    var tempSpecialDays: [SpecialDay] = []
    var sections: [Section] = []
            
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //read XML file ---------------------------------------------------------------
        if WebContent { //read from WebURL
            
            if let myURL = NSURL(string: "http://85.233.100.73/DEV/AusZeitWeb.xml") {
                
                if let parser = XMLParser(contentsOf: myURL as URL) {
                    parser.delegate = self
                    parser.parse()
                }
            }
            else {
                print("URL not defined properly")
            }
            
        } else { //reade local file
            if let path = Bundle.main.url(forResource: "AusZeit", withExtension: "xml") {
                
                if let parser = XMLParser(contentsOf: path) {
                    parser.delegate = self
                    parser.parse()
                }
            }
            else {
                print("Can't find local file")
            }
        }
        
                
        //enum XML Objects for testing -------------------------------------------------
        var i = 0
        var SectionCount = 0
        
        print("test")
        while SectionCount < sections.count {
            print(sections[SectionCount].BeginSection)
            print(sections[SectionCount].EndSection)
            print(sections[SectionCount].Season)
            print(sections[SectionCount].Background)
            
            while i < sections[SectionCount].SpecialDays.count {
                print(sections[SectionCount].SpecialDays[i].spDate)
                print(sections[SectionCount].SpecialDays[i].spText)
                print(sections[SectionCount].SpecialDays[i].spImage)
                i += 1
            }
            print("")
            SectionCount += 1
            i = 0
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //parser section ==============================
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        eName = elementName
        
        if elementName == "Section" {
            
            BeginSection = String()
            EndSection = String()
            Season = String()
            Background = String()
            
            tempSpecialDays.removeAll()
            
        }
        if elementName == "SpecialDay" {
            
            aspDate = String()
            aspText = String()
            aspImage = String()
            
        }
    }
    
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        let section = Section()
        let tempSpecialDay = SpecialDay()
        
        if elementName == "Section" {
            
            section.BeginSection = BeginSection
            section.EndSection = EndSection
            section.Season = Season
            section.Background = Background
            
            section.SpecialDays = tempSpecialDays
            sections.append(section)
            
        }
        if elementName == "SpecialDay" {
            
            tempSpecialDay.spDate = aspDate
            tempSpecialDay.spText = aspText
            tempSpecialDay.spImage = aspImage
            
            tempSpecialDays.append(tempSpecialDay)
           
        }
        
    }
    
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
       let data = string.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if (!data.isEmpty) {
            if eName == "BeginSection" {
                BeginSection += data
            } else if eName == "EndSection" {
                EndSection += data
            } else if eName == "Season" {
                Season += data
            }else if eName == "Background" {
                Background += data
            }else if eName == "Date" {
                aspDate += data
            }else if eName == "Text" {
                aspText += data
            }else if eName == "Image" {
                aspImage += data
            }
       }
    }
    
}

