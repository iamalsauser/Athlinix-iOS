// MatchModel.swift

import Foundation

// Model for match statistics for each team
struct MatchStats {
    let fieldGoals: Int
    let threePFieldGoals: Int
    let freeThrows: Int
}

// Model for a match between two teams
struct Match: Identifiable {
    let id = UUID()  // Unique identifier for each match
    let teamA: String  // Name of the first team
    let teamB: String  // Name of the second team
    let scoreA: Int  // Score of the first team
    let scoreB: Int  // Score of the second team
    let date: String  // Date of the match
    let team1Stats: MatchStats  // Stats for the first team
    let team2Stats: MatchStats  // Stats for the second team
}
