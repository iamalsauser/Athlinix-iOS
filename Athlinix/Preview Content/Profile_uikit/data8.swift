import UIKit
import Foundation

struct User8 {
    // Basic Info
    let userName: String             // Athlete's name (e.g., "Vivek Jaglan")
    let isVerified: Bool             // Verification status (e.g., true for the verified badge)
    let playerOrCoach: String        // Role (e.g., "Player" or "Coach")
    let experience: String           // Years of experience (e.g., "11 yrs exp.")
    let bio: String                  // User bio (e.g., "Basketball player with a passion...")

    // Profile Picture and Background
    let profilePicture: UIImage      // Profile picture
    let backgroundPicture: UIImage   // Background image

    // Stats
    let position: String             // Player's position (e.g., "PF")
    let matches: Int                 // Number of matches played (e.g., 24)
    let height: String               // Height (e.g., "6'11\"")
    let weight: Int                  // Weight (e.g., 265 lbs)
    let ppg: Double                  // Points per game (e.g., 17.8)
    let bpg: Double                  // Blocks per game (e.g., 3.4)
    let ast: Int                     // Assists (e.g., 9)

    // Teams
    let teams: [Team8]                // List of teams the user is associated with

    // Best Game Stats
    let bestGame: BestGame8           // Best game details

    // Feed Posts
    let feed: [Feed8]                 // List of feed posts
}

struct Team8 {
    let teamName: String             // Team name (e.g., "Kings")
    let teamLogo: UIImage            // Team logo image
}

struct BestGame8 {
    let myTeamName: String           // User's team name (e.g., "LA Lakers")
    let myTeamLogo: UIImage          // User's team logo
    let opponentTeamName: String     // Opponent team name (e.g., "BFI")
    let opponentTeamLogo: UIImage    // Opponent team logo
    let myTeamFieldGoals: Int        // My team's field goals (e.g., 47)
    let myTeam3PFieldGoals: Int      // My team's 3P field goals (e.g., 10)
    let myTeamFreeThrows: Int        // My team's free throws (e.g., 6)
    let opponentFieldGoals: Int      // Opponent's field goals (e.g., 47)
    let opponent3PFieldGoals: Int    // Opponent's 3P field goals (e.g., 7)
    let opponentFreeThrows: Int      // Opponent's free throws (e.g., 3)
}

struct Feed8 {
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


