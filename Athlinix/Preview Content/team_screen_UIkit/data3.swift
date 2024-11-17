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
