//
//  data.swift
//  GamePlay
//
//  Created by admin65 on 19/11/24.
//
import Foundation
//MARK: STRUCTS
struct MatchStatskit: Codable {
    let rebounds: Int
    let steals: Int
    let name: String
    let assists: Int
    let id: String
    let matchDate: TimeInterval
    let points: Int
    let blocks: Int
}

struct TeamPerformance: Codable {
    let playerName: String
    let score: CGFloat
    let image: String
}

struct MissesVsMade: Codable{
    let playerName: String
    let freethrowsmade: Int
    let freethrowsmissed: Int
    let twoptfgmade: Int
    let twoptfgmissed: Int
    let threeptfgmissed: Int
    let threeptfgmade: Int
}

//MARK: FUNCS

func fetchMatchStats() -> [MatchStatskit]? {
    guard let path = Bundle.main.path(forResource: "stats", ofType: "json"),
          let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
        print("Failed to load JSON file.")
        return nil
    }
    
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    
    do {
        let stats = try decoder.decode([MatchStatskit].self, from: data)
        return stats
    } catch {
        print("Failed to decode JSON: \(error)")
        return nil
    }
}
//func fetchMatchStats(from filename: String) -> [MatchStatskit] {
//    let fileManager = FileManager.default
//    // Get the Documents directory in the current app sandbox
//    guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
//        print("Failed to get the documents directory URL.")
//        return []
//    }
//
//    let fileURL = documentsURL.appendingPathComponent(filename)
//
//    // Attempt to load and decode the JSON data
//    guard let data = try? Data(contentsOf: fileURL) else {
//        print("Failed to load data from \(fileURL.path)")
//        return []
//    }
//
//    let decoder = JSONDecoder()
//    decoder.dateDecodingStrategy = .secondsSince1970
//
//    do {
//        let matchStats = try decoder.decode([MatchStatskit].self, from: data)
//        return matchStats
//    } catch {
//        print("Failed to decode JSON: \(error)")
//        return []
//    }
//}



func extractGraphData(stats: [MatchStatskit]) -> ([CGFloat], [CGFloat], [CGFloat]) {
    var pointsData: [CGFloat] = []
    var reboundsData: [CGFloat] = []
    var assistsToTurnoverData: [CGFloat] = [] // Assuming turnover data is available
    
    for stat in stats {
        pointsData.append(CGFloat(stat.points))
        reboundsData.append(CGFloat(stat.rebounds))
        
        // For assists-to-turnover ratio, assume turnovers are available in the JSON
        let turnovers = max(CGFloat(stat.blocks), 1) // Replace 'blocks' with actual turnover data
        assistsToTurnoverData.append(CGFloat(stat.assists) / turnovers)
    }
    
    return (pointsData, reboundsData, assistsToTurnoverData)
}

func fetchTeamPerformanceData() -> [TeamPerformance]? {
    guard let path = Bundle.main.path(forResource: "team", ofType: "json"),
          let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
        print("Failed to load JSON file.")
        return nil
    }
    
    let decoder = JSONDecoder()
    do {
        let teamData = try decoder.decode([String: [TeamPerformance]].self, from: data)
        return teamData["teamPerformance"]
    } catch {
        print("Failed to decode JSON: \(error)")
        return nil
    }
}
