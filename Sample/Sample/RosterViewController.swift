//
//  RosterViewController.swift
//  Sample
//
//  Created by Eric Ito on 11/4/14.
//  Copyright (c) 2014 Eric Ito. All rights reserved.
//

import Foundation
import UIKit
import NHLKit

class RosterViewContorller: UITableViewController {
    
    // MARK: Properties
    private var roster: Roster?
    private let team: Team!
    private var currentRequest: Request?
    
    // MARK: Initializers
    
    init(team aTeam: Team) {
        team = aTeam
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        println("cancelling")
        currentRequest?.cancel()
    }
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = team.name
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "ROSTER")
        
        currentRequest = NHLRequestManager.fetchRoster(team) { [weak self] (roster, error) in
            
            if let error = error {
                println("error: \(error)")
            } else if let roster = roster {
                self?.roster = roster
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var sections = 0
        sections += min(1, roster?.goalies.count ?? 0)
        sections += min(1, roster?.defensemen.count ?? 0)
        sections += min(1, roster?.forwards.count ?? 0)
        return sections
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return roster?.goalies.count ?? 0
        } else if section == 1 {
            return roster?.defensemen.count ?? 0
        } else {
            return roster?.forwards.count ?? 0
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Goalies"
        } else if section == 1 {
            return "Defensemen"
        } else {
            return "Forwards"
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("ROSTER", forIndexPath: indexPath) as! UITableViewCell
        
        if indexPath.section == 0 {
            let goalie = roster!.goalies[indexPath.row]
            cell.textLabel?.text = goalie.displayString()
        } else if indexPath.section == 1 {
            let defenseman = roster!.defensemen[indexPath.row]
            cell.textLabel?.text = defenseman.displayString()
        } else {
            let forward = roster!.forwards[indexPath.row]
            cell.textLabel?.text = forward.displayString()
        }
        return cell
    }
}