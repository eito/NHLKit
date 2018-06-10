//
//  Roster.swift
//  NHLKit
//
//  Created by Eric Ito on 11/4/14.
//  Copyright (c) 2014 Eric Ito. All rights reserved.
//

import Foundation

public class Roster: JSONCoding, DebugPrintable {
    
    public var team: Team?
    public private(set) var goalies: [Goalie]!
    public private(set) var defensemen: [Skater]!
    public private(set) var forwards: [Skater]!
    
    public var count: Int? {
        get {
            return goalies.count + defensemen.count + forwards.count
        }
    }
    
    public var skaters: [Skater]? {
        return defensemen + forwards
    }
    
    public func decodeStatJSON(JSON: [String:AnyObject]) {
        var skaterStatsMap = [Int:String]()
        if let skatersJSON = JSON["skaterData"] as? [[String:AnyObject]] {
            for skaterJSON in skatersJSON {
                if let i = skaterJSON["id"] as? Int {
                    skaterStatsMap[i] = (skaterJSON["data"] as! String)
                }
            }
        }
        
        if let skaters = skaters {
            for skater in skaters {
                if let statString = skaterStatsMap[skater.playerID] {
                    skater.decodeStatString(statString)
                }
            }
        }

        var goalieStatsMap = [Int:String]()
        if let goaliesJSON = JSON["goalieData"] as? [[String:AnyObject]] {
            for goalieJSON in goaliesJSON {
                if let i = goalieJSON["id"] as? Int {
                    goalieStatsMap[i] = (goalieJSON["data"] as! String)
                }
            }
        }
        
        for goalie in goalies {
            if let statString = goalieStatsMap[goalie.playerID] {
                goalie.decodeStatString(statString)
            }
        }
    }
    
    // MARK: JSONCoding
    
    public required init(JSON: [String : AnyObject]) {
        if let goaliesJSON = JSON["goalie"] as? [[String:AnyObject]]{
            goalies = [Goalie]()
            for goalieJSON in goaliesJSON {
                goalies.append(Goalie(JSON: goalieJSON))
            }
            
        }
        
        if let defensemenJSON = JSON["defensemen"] as? [[String:AnyObject]] {
            defensemen = [Skater]()
            for defensemenJSON in defensemenJSON {
                defensemen.append(Skater(JSON: defensemenJSON))
            }
        }
        
        if let forwardsJSON = JSON["forwards"] as? [[String:AnyObject]] {
            forwards = [Skater]()
            for forwardsJSON in forwardsJSON {
                forwards.append(Skater(JSON: forwardsJSON))
            }
        }
    }
    
    // MARK: DebugPrintable
    
    public var debugDescription: String {
        get {
            return "Team: \(team!.name)\nGoalies: \(goalies)\nDefensemen: \(defensemen)\n Forwards: \(forwards)\n\n\nSkaters: \(skaters)"
        }
    }
}