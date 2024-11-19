import UIKit
import Foundation

struct AthleteMainStats {
    let username: String
    let name: String
    let profilePicture: String // Asset name for the profile picture
    let ppg: Double
    let bpg: Double
    let ast: Double
    let pointsScoredMonthly: [Int] // Points scored in the last 10 months
    let tournamentsPlayed: Int
    let standAloneMatchesPlayed: Int
    let totalTournamentPoints: Int
    let totalStandAlonePoints: Int
}

struct TeamHome {
    let name: String
    let image: UIImage
    let twoPointFieldGoals: Int
    let threePointFieldGoals: Int
    let freeThrows: Int
}


let userStats = [
    AthleteMainStats(
        username: "akshita",
        name: "Akshita Sharma",
        profilePicture: "profile", // Example asset name
        ppg: 27.5,
        bpg: 7.2,
        ast: 8.1,
        pointsScoredMonthly: [120, 103, 38, 57, 85, 89, 102, 123, 98],
        tournamentsPlayed: 150,
        standAloneMatchesPlayed: 100,
        totalTournamentPoints: 451,
        totalStandAlonePoints: 258
    )]


let athleteStats = [
    AthleteMainStats(
        username: "lebron_5",
        name: "LeBron",
        profilePicture: "Images13", // Example asset name
        ppg: 27.5,
        bpg: 7.2,
        ast: 8.1,
        pointsScoredMonthly: [120, 103, 38, 57, 85, 89, 102, 123, 95, 110],
        tournamentsPlayed: 15,
        standAloneMatchesPlayed: 10,
        totalTournamentPoints: 451,
        totalStandAlonePoints: 258
    ),
    AthleteMainStats(
        username: "jordan_x",
        name: "Michael",
        profilePicture: "Images15", // Example asset name
        ppg: 30.1,
        bpg: 6.2,
        ast: 5.3,
        pointsScoredMonthly: [140, 110, 45, 67, 95, 92, 112, 133, 100, 120],
        tournamentsPlayed: 18,
        standAloneMatchesPlayed: 8,
        totalTournamentPoints: 500,
        totalStandAlonePoints: 300
    )
]
