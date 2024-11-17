import Foundation

struct allStatsDataModel {
    let totalPoints: Int
    let gamesPlayed: Int
    let pointsPerGame: Double
    let percentageChange: Double

    let sampleData1: [(String, Double)]
    let sampleData2: [(String, Double)]
}

extension allStatsDataModel {
    static let mockData = allStatsDataModel(
        totalPoints: 1260,
        gamesPlayed: 63,
        pointsPerGame: 24.3,
        percentageChange: 3.5,
        sampleData1: [
            ("Game 1", 15),
            ("Game 2", 20),
            ("Game 3", 18),
            ("Game 4", 25),
            ("Game 5", 30)
        ],
        sampleData2: [
            ("Game 1", 10),
            ("Game 2", 25),
            ("Game 3", 20),
            ("Game 4", 15),
            ("Game 5", 30)
        ]
    )
}
