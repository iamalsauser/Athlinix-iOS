//import Foundation
//
//// Define the structure for your chart data
//struct StatsDataModel {
//    var date: String
//    var value: Double
//}
//
//// Sample Data for Assist and Rebounds
//struct SampleData {
//    static let assistData: [StatsDataModel] = [
//        StatsDataModel(date: "Oct 1", value: 10),
//        StatsDataModel(date: "Oct 2", value: 15),
//        StatsDataModel(date: "Oct 3", value: 20),
//        StatsDataModel(date: "Oct 4", value: 25),
//        StatsDataModel(date: "Oct 5", value: 30)
//    ]
//    
//    static let reboundData: [StatsDataModel] = [
//        StatsDataModel(date: "Oct 1", value: 30),
//        StatsDataModel(date: "Oct 2", value: 25),
//        StatsDataModel(date: "Oct 3", value: 20),
//        StatsDataModel(date: "Oct 4", value: 15),
//        StatsDataModel(date: "Oct 5", value: 10)
//    ]
//}
//import Foundation
//
//// Define the structure for the JSON data
//struct PlayerStat: Codable {
//    let name: String
//    let id: String
//    let assists: Int
//    let blocks: Int
//    let points: Int
//    let steals: Int
//    let matchDate: TimeInterval
//    let rebounds: Int
//}
//struct StatsDataModel2: Identifiable {
//    var id = UUID() // To conform to Identifiable for List compatibility
//    var date: String
//    var value: Double
//}
//
//// Utility function to load JSON data from a file
//func loadPlayerStats(from filename: String) -> [PlayerStat] {
//    guard let url = Bundle.main.url(forResource: filename, withExtension: "json"),
//          let data = try? Data(contentsOf: url) else {
//        return []
//    }
//    
//    let decoder = JSONDecoder()
//    return (try? decoder.decode([PlayerStat].self, from: data)) ?? []
//}
//
//// Convert PlayerStat to StatsDataModel for chart data
//func convertToStatsDataModel(from stats: [PlayerStat], key: KeyPath<PlayerStat, Int>) -> [StatsDataModel2] {
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "MMM d"
//    
//    return stats.map {
//        let date = Date(timeIntervalSince1970: $0.matchDate)
//        return StatsDataModel2(
//            date: dateFormatter.string(from: date),
//            value: Double($0[keyPath: key])
//        )
//    }
//}
//
//// StatsDataModel to match chart data format
//struct StatsDataModel1 {
//    var date: String
//    var value: Double
//}
