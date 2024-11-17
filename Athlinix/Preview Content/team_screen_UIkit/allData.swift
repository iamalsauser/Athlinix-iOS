import UIKit

// Sample Athletes
let athlete1 = Athlete(
    uid: UUID(),
    username: "daniel2",
    name: "Daniel",
    height: 6.5,
    weight: 210,
    yearsOfExperience: 5,
    profileImage: "1", // Image name in assets
    region: "USA",
    achievements: ["MVP 2020", "All-Star 2021"]
)

let athlete2 = Athlete(
    uid: UUID(),
    username: "vihan",
    name: "Vivek",
    height: 6.3,
    weight: 190,
    yearsOfExperience: 4,
    profileImage: "2",
    region: "India",
    achievements: ["Best Rookie 2019"]
)

// Additional athletes
let athlete3 = Athlete(uid: UUID(), username: "vedit", name: "Daniel", height: 6.4, weight: 200, yearsOfExperience: 6, profileImage: "3", region: "Australia", achievements: ["Top Scorer 2018"])
let athlete4 = Athlete(uid: UUID(), username: "kish", name: "Vivek", height: 6.1, weight: 180, yearsOfExperience: 3, profileImage: "4", region: "UK", achievements: ["Defensive Player 2022"])

// Sample Coaches
let coach1 = Coach(
    uid: UUID(),
    username: "akshita13",
    name: "Akshita",
    height: 5.8,
    weight: 150,
    yearsOfExperience: 10,
    profileImage: "5", // Image name in assets
    region: "India",
    playersCoached: [athlete1, athlete2],
    achievements: ["Coach of the Year 2021"]
)

let coach2 = Coach(
    uid: UUID(),
    username: "coach_vivek",
    name: "Vivek",
    height: 5.9,
    weight: 160,
    yearsOfExperience: 8,
    profileImage: "6",
    region: "USA",
    playersCoached: [athlete3, athlete4],
    achievements: ["Hall of Fame 2020"]
)

// Sample Team
let teamSampleData = Teamui(
    uid: UUID(),
    teamName: "Basketball Federation India",
    moto: "Unity in Strength",
    region: "India",
    members: [athlete1, athlete2, athlete3, athlete4],
    coach: [coach1],
    wins: 15,
    losses: 5,
    ties: 2
)
