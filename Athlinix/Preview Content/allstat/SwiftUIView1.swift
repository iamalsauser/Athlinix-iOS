import Foundation

// Define the structure for your chart data
struct StatsDataMode {
    var date: String
    var value: Double
}

// Sample Data for Assist and Rebounds
struct SampleData {
    static let assistData: [StatsDataMode] = [
        StatsDataMode(date: "Oct 1", value: 10),
        StatsDataMode(date: "Oct 2", value: 15),
        StatsDataMode(date: "Oct 3", value: 20),
        StatsDataMode(date: "Oct 4", value: 25),
        StatsDataMode(date: "Oct 5", value: 30)
    ]

    static let reboundData: [StatsDataMode] = [
        StatsDataMode(date: "Oct 1", value: 30),
        StatsDataMode(date: "Oct 2", value: 25),
        StatsDataMode(date: "Oct 3", value: 20),
        StatsDataMode(date: "Oct 4", value: 15),
        StatsDataMode(date: "Oct 5", value: 10)
    ]
}
