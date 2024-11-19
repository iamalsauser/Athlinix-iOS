//
//  data.swift
//  teamScreen
//
//  Created by admin65 on 15/11/24.
//
import UIKit

// Sample Data
struct Athlete {
    var uid: UUID
    var username: String
    var name: String
    var height: Double
    var weight: Double
    var yearsOfExperience: Int
    var profileImage: String
    var region: String
    var achievements: [String]
}

struct Coach {
    var uid: UUID
    var username: String
    var name: String
    var height: Double
    var weight: Double
    var yearsOfExperience: Int
    var profileImage: String
    var region: String
    var playersCoached: [Athlete]
    var achievements: [String]
}

struct Teamui {
    var uid: UUID // Unique ID for data fetching
    var teamName: String
    var moto:String
    var region: String
    var members: [Athlete] // Relationship with Athlete
    var coach: [Coach] // Relationship with Coach
    var wins: Int
    var losses: Int
    var ties: Int
}

//explore_uikit
struct Feed {
    let athleteName: String         // Athlete's name (e.g., "David and 2 others")
    let athleteProfile: UIImage     // Athlete's profile picture
    let teamName: String            // Team name (e.g., "Phoenix Suns")
    let teamLogo: UIImage           // Team logo image
    let location: String            // Location (e.g., "Los Angeles")
    let likeCount: Int              // Number of likes
    let image1: UIImage             // First image for the feed
    let image2: UIImage             // Second image for the feed
    let image3: UIImage             // Third image for the feed
}

//allmatch_uikit
struct Matchkit {
    let homeTeamLogo: UIImage
    let awayTeamLogo: UIImage
    let homeTeamName: String
    let awayTeamName: String
    let fieldGoals: (home: Int, away: Int)
    let threePointers: (home: Int, away: Int)
    let freeThrows: (home: Int, away: Int)
    let date: Date
}


//matches_mainui

struct PlayerStats5 {
    let playerName: String
    let rebounds: Int
    let assists: Int
    let fouls: Int
    let points: Int
}

// Game Stats Struct
struct GameStats {
    let fieldGoals: Int
    let freeThrows: Int
    let threePointFieldGoals: Int
    let totalRebounds: Int
    let assists: Int
    let fouls: Int
    let steals: Int
}

// Team Struct
struct Team5 {
    let name: String
    let teamLogo: UIImage? // Optional to allow nil if no logo is available
    let players: [PlayerStats5]
    let gameStats: GameStats
    let winPercentage: Double // Add win percentage
    let logo: String // Additional logo identifier or name
}

// Sample Player Stats for Lakers
let team1Players = [
    PlayerStats5(playerName: "LeBron James", rebounds: 12, assists: 10, fouls: 2, points: 28),
    PlayerStats5(playerName: "Anthony Davis", rebounds: 14, assists: 4, fouls: 3, points: 22),
    PlayerStats5(playerName: "Austin Reaves", rebounds: 5, assists: 6, fouls: 1, points: 15),
    PlayerStats5(playerName: "D'Angelo Russell", rebounds: 3, assists: 8, fouls: 2, points: 19),
    PlayerStats5(playerName: "Rui Hachimura", rebounds: 7, assists: 2, fouls: 1, points: 10)
]

// Sample Player Stats for BFI
let team2Players = [
    PlayerStats5(playerName: "Himani Gupta", rebounds: 11, assists: 7, fouls: 1, points: 25),
    PlayerStats5(playerName: "Sakshi Sharma", rebounds: 9, assists: 5, fouls: 0, points: 18),
    PlayerStats5(playerName: "Akshita Verma", rebounds: 6, assists: 4, fouls: 2, points: 14),
    PlayerStats5(playerName: "Banshika Singh", rebounds: 8, assists: 6, fouls: 1, points: 20),
    PlayerStats5(playerName: "Harshita Mehta", rebounds: 7, assists: 3, fouls: 0, points: 13)
]

// Sample Game Stats for Lakers
let team1GameStats = GameStats(
    fieldGoals: 41,
    freeThrows: 10,
    threePointFieldGoals: 13,
    totalRebounds: 51,
    assists: 21,
    fouls: 7,
    steals: 1
)

// Sample Game Stats for BFI
let team2GameStats = GameStats(
    fieldGoals: 39,
    freeThrows: 12,
    threePointFieldGoals: 23,
    totalRebounds: 38,
    assists: 28,
    fouls: 5,
    steals: 4
)

// Placeholder logos
let lakersLogo = UIImage(named: "lakers") // Replace with actual asset name
let bfiLogo = UIImage(named: "cavs")   // Replace with actual asset name

// Teams
let team1 = Team5(
    name: "Lakers",
    teamLogo: lakersLogo,
    players: team1Players,
    gameStats: team1GameStats,
    winPercentage: 0.75, // Example win percentage
    logo: "team4"
)

let team2 = Team5(
    name: "BFI",
    teamLogo: bfiLogo,
    players: team2Players,
    gameStats: team2GameStats,
    winPercentage: 0.68, // Example win percentage
    logo: "team5"
)
