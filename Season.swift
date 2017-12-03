//
//  Season.swift
//  XMLPareserTest
//
//  Created by Juergen Schwoediauer on 26.11.17.
//  Copyright © 2017 Juergen Schwoediauer. All rights reserved.
//

import Foundation


public class SpecialDay {
    public var spDate: String = String()
    public var spText: String = String()
    public var spImage: String = String()
    
}


public class Section {
    
    public var BeginSection: String = String()
    public var EndSection: String = String()
    public var Season: String = String()
    public var Background: String = String()
    public var SpecialDays: [SpecialDay] = []
    
}
