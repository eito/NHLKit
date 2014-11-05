//
//  NHLRequestManager.swift
//  NHLKit
//
//  Created by Eric Ito on 11/4/14.
//  Copyright (c) 2014 Eric Ito. All rights reserved.
//

import Foundation

public class NHLRequestManager {
    
    public class func fetchRoster(team: String, completion: ((roster: Roster?, error: NSError?) -> Void)?) -> Request? {
        let requestURLString = String(format: RosterTemplateURLString, team)
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