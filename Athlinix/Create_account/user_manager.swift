import Foundation

//struct User_: Codable {
//    var email: String
//    var password: String
//}
//
//struct UserDetails: Codable {
//    var name: String
//    var age: Int
//    var height: Double
//    var weight: Double
//    var position: String
//    var skillLevel: String
//    var yearsPlayed: Int
//    var phoneNumber: String?
//    var birthDate: Date?
//    var gender: String?
//    var profilePhoto: Data?
//}
//
//struct CompleteUser: Codable {
//    var basicInfo: User_
//    var additionalInfo: UserDetails
//}

class UserManager {
    static let shared = UserManager()
    private let completeUsersKey = "storedCompleteUsers"

    // Save a new complete user
    func saveCompleteUser(_ user: CompleteUser) {
        var users = getAllCompleteUsers()
        users.append(user)
        if let encoded = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(encoded, forKey: completeUsersKey)
        }
    }

    // Retrieve all complete users
    func getAllCompleteUsers() -> [CompleteUser] {
        if let savedData = UserDefaults.standard.data(forKey: completeUsersKey),
           let users = try? JSONDecoder().decode([CompleteUser].self, from: savedData) {
            print("All stored complete users: \(users)")
            return users
        }
        return []
    }

    // Retrieve a specific user by email
    func getCompleteUser(byEmail email: String) -> CompleteUser? {
        return getAllCompleteUsers().first { $0.basicInfo.email == email }
    }

    // Update data for the current user
    func updateCurrentUserData(key: String, value: Any) {
        guard let loggedInUserEmail = getLoggedInUserEmail() else { return }
        var users = getAllCompleteUsers()

        if let index = users.firstIndex(where: { $0.basicInfo.email == loggedInUserEmail }) {
            var user = users[index]

            // Use key-path reflection for property update
            switch key {
            case "phoneNumber":
                if let phone = value as? String { user.additionalInfo.phoneNumber = phone }
            case "birthDate":
                if let birthDate = value as? Date { user.additionalInfo.birthDate = birthDate }
            case "gender":
                if let gender = value as? String { user.additionalInfo.gender = gender }
            case "profilePhoto":
                if let photoData = value as? Data { user.additionalInfo.profilePhoto = photoData }
            default:
                break
            }

            // Update the user in the array
            users[index] = user
            saveAllCompleteUsers(users)
        }
    }

    // Save all complete users
    private func saveAllCompleteUsers(_ users: [CompleteUser]) {
        if let encoded = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(encoded, forKey: completeUsersKey)
        }
    }

    // Mock function to get the logged-in user's email
    func getLoggedInUserEmail() -> String? {
        // Replace with real implementation (e.g., from a session manager)
        return UserDefaults.standard.string(forKey: "loggedInUserEmail")
    }

    // Authenticate a user by email and password
    func authenticateUser(email: String, password: String) -> Bool {
        if let user = getCompleteUser(byEmail: email), user.basicInfo.password == password {
            return true
        }
        return false
    }
}
