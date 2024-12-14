import Foundation

struct User_: Codable {
    var email: String
    var password: String
}

struct UserDetails: Codable {
    var name: String
    var age: Int
    var height: Double
    var weight: Double
    var position: String
    var skillLevel: String
    var yearsPlayed: Int
    var phoneNumber: String?
    var birthDate: Date?
    var gender: String?
    var profilePhoto: Data?
}

struct CompleteUser: Codable {
    var basicInfo: User_
    var additionalInfo: UserDetails
}
