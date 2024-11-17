import Foundation

// Define the structure for your chart data
struct StatsDataModel {
    var date: String
    var value: Double
}

// Sample Data for Assist and Rebounds
struct SampleData {
    static let assistData: [StatsDataModel] = [
        StatsDataModel(date: "Oct 1", value: 10),
        StatsDataModel(date: "Oct 2", value: 15),
        StatsDataModel(date: "Oct 3", value: 20),
        StatsDataModel(date: "Oct 4", value: 25),
        StatsDataModel(date: "Oct 5", value: 30)
    ]
    
    static let reboundData: [StatsDataModel] = [
        StatsDataModel(date: "Oct 1", value: 30),
        StatsDataModel(date: "Oct 2", value: 25),
        StatsDataModel(date: "Oct 3", value: 20),
        StatsDataModel(date: "Oct 4", value: 15),
        StatsDataModel(date: "Oct 5", value: 10)
    ]
}
