//
//  Player.swift
//  NHLKit
//
//  Created by Eric Ito on 11/4/14.
//  Copyright (c) 2014 Eric Ito. All rights reserved.
//

import Foundation

public class Player: JSONCoding, DebugPrintable {
    
    // MARK: Properties
    
    public private(set) var position: String!
    public private(set) var playerID: Int!
    public private(set) var weight: Int!
    public private(set) var height: String!
    public private(set) var imageURL: NSURL!
    public private(set) var birthplace: String!
    public private(set) var age: Int!
    public private(set) var name: String!
    public private(set) var birthdate: String!
    public private(set) var number: Int?
    public private(set) var twitterURL: NSURL?
    public private(set) var twitterHandle: String?
    
    // MARK: Methods
    
    public func displayString() -> String {
        var display = ""
        if let n = number {
            display += "#\(n) - "
        } else {
            display += "# N/A - "
        }
        display += "\(name)"
        return display
    }

    // MARK: JSONCoding
    
    public required init(JSON: [String : AnyObject]) {
        position = JSON["position"] as String
        playerID = JSON["id"] as Int
        weight = JSON["weight"] as Int
        height = JSON["height"] as String
        
        if let url = JSON["imageUrl"] as? String {
            imageURL = NSURL(string: url)
        }
        
        birthplace = JSON["birthplace"] as String
        age = JSON["age"] as Int
        name = JSON["name"] as String
        birthdate = JSON["birthdate"] as String
        number = JSON["number"] as? Int
        
        if let url = JSON["twitterURL"] as? String {
            twitterURL = NSURL(string: url)
        }
        twitterHandle = JSON["twitterHandle"] as? String
    }
    
    // MARK: DebugPrintable
    
    public var debugDescription: String {
        get {
            return "#\(number) \(name)"
        }
    }
}