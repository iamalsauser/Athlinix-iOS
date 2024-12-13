import Foundation

class UserManager {
    static let shared = UserManager()
    
    private let usersKey = "storedUsers"
    
    // Save a new user
    func saveUser(_ user: User_) {
        var users = getAllUsers()
        users.append(user)
        if let encoded = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(encoded, forKey: usersKey)
        }
    }
    
    

    
    // Retrieve all users
    func getAllUsers() -> [User_] {
        if let savedData = UserDefaults.standard.data(forKey: usersKey),
           let users = try? JSONDecoder().decode([User_].self, from: savedData) {
            return users
        }
        return []
    }
    
    // Retrieve a specific user by email
    func getUser(byEmail email: String) -> User_? {
        return getAllUsers().first { $0.email == email }
    }
}

extension UserManager {
    func authenticateUser(email: String, password: String) -> Bool {
        if let user = getUser(byEmail: email), user.password == password {
            return true
        }
        return false
    }
}
