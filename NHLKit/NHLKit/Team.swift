//
//  Team.swift
//  NHLKit
//
//  Created by Eric Ito on 11/4/14.
//  Copyright (c) 2014 Eric Ito. All rights reserved.
//

import Foundation

public class Team {
    
    public let name: String!
    public let abbreviation: String!
    
    public init(abbreviation a: String, name n: String) {
        name = n
        abbreviation = a
    }
}