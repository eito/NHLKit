//
//  ViewController.swift
//  Sample
//
//  Created by Eric Ito on 11/4/14.
//  Copyright (c) 2014 Eric Ito. All rights reserved.
//

import UIKit
import NHLKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.title = "Teams"
        
        NHLRequestManager.fetchTeams { (teams, error) in
            
            guard error == nil else {
                print("Error fetching teams")
                return
            }
            
            print(teams!)
        }
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CONTENT")
        view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        return UITableViewCell()
        
//        var cell = tableView.d("CONTENT", forIndexPath: indexPath) as! UITableViewCell
//
//        let teamAbbrev = NHLTeams[indexPath.row]
//        let team: Team! = NHLTeamMap[teamAbbrev]
//        cell.textLabel?.text = team.name
//        cell.accessoryType = .DisclosureIndicator
//        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NHLTeams.count
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
//        let team = NHLTeams[indexPath.row]
//        let rvc = RosterViewContorller(team: NHLTeamMap[team]!)
//        navigationController?.pushViewController(rvc, animated: true)
    }
}

