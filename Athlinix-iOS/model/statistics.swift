import Foundation
import SwiftUI

struct Statistics: Codable, Identifiable, Hashable {
    var id: Int?
    var createdAt: Date?
    var userID: UUID
    var tp: Int
    var fgm: Int
    var fga: Int
    var tpm: Int
    var tpa: Int
    var threepm: Int
    var threepa: Int
    var ftm: Int
    var fta: Int
    var oreb: Int
    var dreb: Int
    var ast: Int
    var to: Int
    var stl: Int
    var pf: Int
    var blk: Int
    var isComplete: Bool
    var fgp: Float?
    var threepp: Float?
    var ftp: Float?
    var tpp: Float?
    var efgp: Float?
    var tsp: Float?
    var top: Float?

    
    var playerPosition: String?
    var height: Double?
    var weight: Double?
    var birthdate: Date?
    var gender: String?
    var location: String?

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case userID = "user_id"
        case tp, fgm, fga, tpm, tpa, threepm, threepa, ftm, fta, oreb, dreb, ast, to, stl, pf, blk, isComplete = "is_complete"
        case fgp, threepp, ftp, tpp, efgp, tsp, top
        case playerPosition = "player_position"
        case height, weight, birthdate, gender, location
    }
}
