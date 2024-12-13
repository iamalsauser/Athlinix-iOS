import Foundation

struct User_: Codable, Identifiable {
    let id: UUID = UUID() // Unique identifier for each user
    let email: String
    let password: String
}


