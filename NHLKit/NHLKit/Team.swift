//
//  Team.swift
//  NHLKit
//
//  Created by Eric Ito on 11/4/14.
//  Copyright (c) 2014 Eric Ito. All rights reserved.
//

import Foundation

public struct Team: Codable {

    public let name: String
    public let abbreviation: String
    public let teamName: String
    public let locationName: String
    public let shortName: String
    private let id: Int
    
    enum CodingKeys:String,CodingKey
    {
        case name
        case abbreviation
        case teamName
        case locationName
        case shortName
        case id
    }
}
