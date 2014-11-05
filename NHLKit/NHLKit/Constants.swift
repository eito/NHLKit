//
//  Constants.swift
//  NHLKit
//
//  Created by Eric Ito on 11/4/14.
//  Copyright (c) 2014 Eric Ito. All rights reserved.
//

import Foundation

// valid years
/*
20112012
20122013
20132014
20142015
*/


// http://nhlwc.cdnak.neulion.com/fs1/nhl/league/teamroster/ANA/iphone/clubroster.json
let RosterTemplateURLString = "http://nhlwc.cdnak.neulion.com/fs1/nhl/league/teamroster/%@/iphone/clubroster.json"

// http://nhlwc.cdnak.neulion.com/fs1/nhl/league/clubschedule/CGY/2014/02/iphone/clubschedule.json
let MonthlyTeamScheduleURLString = "http://nhlwc.cdnak.neulion.com/fs1/nhl/league/clubschedule/%@/%d/%02d/iphone/clubschedule.json"

// http://nhlwc.cdnak.neulion.com/fs1/nhl/league/playerstatsline/20132014/2/ANA/iphone/playerstatsline.json
// 2 == regular season
let TeamPlayerStatsURLString = "http://nhlwc.cdnak.neulion.com/fs1/nhl/league/playerstatsline/%d%d/2/%@/iphone/playerstatsline.json"

// http://nhlwc.cdnak.neulion.com/fs1/nhl/league/playerstatsline/20132014/3/PIT/iphone/playerstatsline.json
// 3 == playoffs
let TeamPlayoffPlayerStatsURLString = "http://nhlwc.cdnak.neulion.com/fs1/nhl/league/playerstatsline/%d%d/3/%@/iphone/playerstatsline.json"

// Overview status
let LeagueLeadersURLString = "http://nhlwc.cdnak.neulion.com/fs1/nhl/league/leagueleaders/iphone/leagueleaders.json"

// Points
let LeagueLeadersPointsURLString = "http://nhlwc.cdnak.neulion.com/fs1/nhl/league/leagueleaders/iphone/points/leagueleaders.json"

// Goals
let LeagueLeadersGoalsURLString = "http://nhlwc.cdnak.neulion.com/fs1/nhl/league/leagueleaders/iphone/goals/leagueleaders.json"

// Assists
let LeagueLeadersAssistsURLString = "http://nhlwc.cdnak.neulion.com/fs1/nhl/league/leagueleaders/iphone/assists/leagueleaders.json"

// +/-
let LeagueLeadersPlusMinusURLString = "http://nhlwc.cdnak.neulion.com/fs1/nhl/league/leagueleaders/iphone/plusminus/leagueleaders.json"

// Wins
let LeagueLeadersWinsURLString = "http://nhlwc.cdnak.neulion.com/fs1/nhl/league/leagueleaders/iphone/wins/leagueleaders.json"

// GAA
let LeagueLeadersGAAURLString = "http://nhlwc.cdnak.neulion.com/fs1/nhl/league/leagueleaders/iphone/gaa/leagueleaders.json"

// Save %
let LeagueLeadersSavePctURLString = "http://nhlwc.cdnak.neulion.com/fs1/nhl/league/leagueleaders/iphone/savepercentage/leagueleaders.json"

// Shutouts
let LeagueLeadersShutoutsURLString = "http://nhlwc.cdnak.neulion.com/fs1/nhl/league/leagueleaders/iphone/shutouts/leagueleaders.json"

// Player Mugshots
// http://tsnimages.tsn.ca/ImageProvider/PlayerHeadshot?seoId=Tanner-Pearson
// Latin alphabets only
// replace spaces with hyphens(-)
// replace aphostrophes(') and dots(.) with nothing
let PlayerMugshotTemplateURLString = "http://tsnimages.tsn.ca/ImageProvider/PlayerHeadshot?seoId=%@"

// http://3.cdn.nhle.com/photos/mugs/thumb/8476822.jpg
let PlayerMugshot2TemplateURLString = "http://3.cdn.nhle.com/photos/mugs/thumb/%@.jpg"

public let NHLTeams = [
    "ANA",
    "ARI",
    "BOS",
    "BUF",
    "CGY",
    "CAR",
    "CHI",
    "COL",
    "CBJ",
    "DAL",
    "DET",
    "EDM",
    "FLA",
    "LAK",
    "MIN",
    "MTL",
    "NSH",
    "NJD",
    "NYI",
    "NYR",
    "OTT",
    "PHI",
    "PIT",
    "SJS",
    "STL",
    "TBL",
    "TOR",
    "VAN",
    "WSH",
    "WPG",
]

public let NHLTeamMap = [
    "ANA" : Team(abbreviation: "ANA", name: "Anaheim Ducks"),
    "ARI" : Team(abbreviation: "ARI", name: "Arizona Coyotes"),
    "BOS" : Team(abbreviation: "BOS", name: "Boston Bruins"),
    "BUF" : Team(abbreviation: "BUF", name: "Buffalo Sabres"),
    "CGY" : Team(abbreviation: "CGY", name: "Calgary Flames"),
    "CAR" : Team(abbreviation: "CAR", name: "Carolina Hurricanes"),
    "CHI" : Team(abbreviation: "CHI", name: "Chicago Blackhawks"),
    "COL" : Team(abbreviation: "COL", name: "Colorado Avalance"),
    "CBJ" : Team(abbreviation: "CBJ", name: "Columbus Blue Jackets"),
    "DAL" : Team(abbreviation: "DAL", name: "Dallas Stars"),
    "DET" : Team(abbreviation: "DET", name: "Detroit Red Wings"),
    "EDM" : Team(abbreviation: "EDM", name: "Edmonton Oilers"),
    "FLA" : Team(abbreviation: "FLA", name: "Florida Panthers"),
    "LAK" : Team(abbreviation: "LAK", name: "Los Angeles Kings"),
    "MIN" : Team(abbreviation: "MIN", name: "Minnesota Wild"),
    "MTL" : Team(abbreviation: "MTL", name: "Montreal Canadiens"),
    "NSH" : Team(abbreviation: "NSH", name: "Nashville Predators"),
    "NJD" : Team(abbreviation: "NJD", name: "New Jersey Devils"),
    "NYI" : Team(abbreviation: "NYI", name: "New York Islanders"),
    "NYR" : Team(abbreviation: "NYR", name: "New York Rangers"),
    "OTT" : Team(abbreviation: "OTT", name: "Ottawa Senators"),
    "PHI" : Team(abbreviation: "PHI", name: "Philadelphia Flyers"),
    "PIT" : Team(abbreviation: "PIT", name: "Pittsburgh Penguins"),
    "SJS" : Team(abbreviation: "SJS", name: "San Jose Sharks"),
    "STL" : Team(abbreviation: "STL", name: "St. Louis Blues"),
    "TBL" : Team(abbreviation: "TBL", name: "Tampa Bay Lightning"),
    "TOR" : Team(abbreviation: "TOR", name: "Toronto Maple Leafs"),
    "VAN" : Team(abbreviation: "VAN", name: "Vancouver Canucks"),
    "WSH" : Team(abbreviation: "WSH", name: "Washington Capitals"),
    "WPG" : Team(abbreviation: "WPG", name: "Winnipeg Jets")
]
