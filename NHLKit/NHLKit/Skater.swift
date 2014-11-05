//
//  Skater.swift
//  NHLKit
//
//  Created by Eric Ito on 11/4/14.
//  Copyright (c) 2014 Eric Ito. All rights reserved.
//

import Foundation

public class Skater: Player {
    
    // "#, POS, NAME, GP, G, A, P, +/-, PIM, S, TOI/G, PP, SH, GW, OT"
    
    // MARK: Properties
    
    public private(set) var goals: Int?
    public private(set) var assists: Int?
    public private(set) var points: Int?
    public private(set) var plusMinus: UInt?
    public private(set) var PIM: Int?
    public private(set) var shots: Int?
    public private(set) var TOI: String?
    public private(set) var PPG: Int?
    public private(set) var SHG: Int?
    public private(set) var GWG: Int?
    public private(set) var OT: Int?
    
    override public func decodeStatString(stats: String) {
        var components = stats.componentsSeparatedByString(", ")

        gamesPlayed = components[3].toInt()
        goals = components[4].toInt()
        assists = components[5].toInt()
        points = components[6].toInt()

        // TODO: parse plus minus
        
        PIM = components[8].toInt()
        shots = components[9].toInt()
        TOI = components[10]
        PPG = components[11].toInt()
        SHG = components[12].toInt()
        GWG = components[13].toInt()
        OT = components[14].toInt()
    }
}