//
//  NHLRequestManager.swift
//  NHLKit
//
//  Created by Eric Ito on 11/4/14.
//  Copyright (c) 2014 Eric Ito. All rights reserved.
//

import Foundation

public class NHLRequestManager {
    
    public class func fetchTeams(completion: (([Team]?, Error?) -> Void)) -> Void {
        
        guard let url = URL(string: "https://statsapi.web.nhl.com/api/v1/teams") else { fatalError() }
        
        let result = Just.get(url)
        
        guard let json = result.json as? [String: Any] else {
            completion(nil, nil)
            return
        }
        
        guard let teamsJSON = json["teams"] as? [[String: Any]] else {
            completion(nil, nil)
            return
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: teamsJSON, options: [])
            let teams = try JSONDecoder().decode([Team].self, from: data)
            completion(teams, nil)
        } catch {
            completion(nil, nil)
        }
    }
    
//    public class func fetchStats(forRoster roster: Roster, completion: ((error: NSError?) -> Void)?) -> Request? {
//        let requestURLString = String(format: TeamPlayerStatsURLString, 2014, 2015)
//        var request: JSONRequest?
//        if let URL = NSURL(string: requestURLString) {
//            request = JSONRequest(URL: URL)
//            request!.completion = { (result, error) in
//
//                if let result = result as? [String:AnyObject] {
//                    roster.decodeStatJSON(result)
//                }
//                dispatch_async(dispatch_get_main_queue()) {
//                    completion?(error: error)
//                    return
//                }
//            }
//            request!.start()
//        }
//        return request
//    }
//
//    public class func fetchRoster(team: Team, completion: ((roster: Roster?, error: NSError?) -> Void)?) -> Request? {
//        let requestURLString = String(format: RosterTemplateURLString, team.abbreviation)
//        var request: JSONRequest? = nil
//        if let URL = NSURL(string: requestURLString) {
//            request = JSONRequest(URL: URL)
//            request!.completion = { (result, error) in
//
//                var processError: NSError?
//                var processResult: Roster?
//                if let error = error {
//                    processError = error
//                } else {
//                    if let JSON = result as? [String:AnyObject] {
//                        processResult = Roster(JSON: JSON)
//                        processResult?.team = team
//                    }
//                }
//                dispatch_async(dispatch_get_main_queue()) {
//                    completion?(roster: processResult, error: processError)
//                    return
//                }
//            }
//            request!.start()
//        }
//        return request
//    }
}
