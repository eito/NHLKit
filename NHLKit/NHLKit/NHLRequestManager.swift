//
//  NHLRequestManager.swift
//  NHLKit
//
//  Created by Eric Ito on 11/4/14.
//  Copyright (c) 2014 Eric Ito. All rights reserved.
//

import Foundation
import NHLKit

public class NHLRequestManager {
    
    public class func fetchStats(forRoster roster: Roster, completion: ((error: NSError?) -> Void)?) -> Request? {
        let requestURLString = String(format: TeamPlayerStatsURLString, 2014, 2015)
        if let URL = NSURL(string: requestURLString) {
            var request = JSONRequest(URL: URL)
            request.completion = { (result, error) in
                
                if let result = result as? [String:AnyObject] {
                    roster.decodeStatJSON(result)
                }

                completion?(error: error)
            }
            request.start()
            return request
        }
        return nil
    }
    
    public class func fetchRoster(team: Team, completion: ((roster: Roster?, error: NSError?) -> Void)?) -> Request? {
        let requestURLString = String(format: RosterTemplateURLString, team.abbreviation)
        if let URL = NSURL(string: requestURLString) {
            var request = JSONRequest(URL: URL)
            request.completion = { (result, error) in
                
                var processError: NSError?
                var processResult: Roster?
                if let error = error {
                    processError = error
                } else {
                    if let JSON = result as? [String:AnyObject] {
                        processResult = Roster(JSON: JSON)
                        processResult?.team = team
                    }
                }
                completion?(roster: processResult, error: processError)
            }
            request.start()
            return request
        }
        return nil
    }
}