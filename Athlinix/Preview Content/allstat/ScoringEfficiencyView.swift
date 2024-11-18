import SwiftUI
import Charts

// Define the structure for scoring efficiency data
struct ScoringEfficiencyData {
    var pointsPerGame: Double
    var percentageChange: Double
    var pointsData: [(String, Double)]
}

struct ScoringEfficiencyView: View {
    var data: ScoringEfficiencyData

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Scoring Efficiency")
                .font(.headline)
                .foregroundColor(.primary)
                .padding(.bottom, 5)
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Points per Game")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("\(String(format: "%.1f", data.pointsPerGame))")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    HStack(spacing: 5) {
                        if data.percentageChange > 0 {
                            Image(systemName: "arrow.up")
                                .foregroundColor(.green)
                            Text("\(String(format: "%.1f", data.percentageChange))%")
                                .foregroundColor(.green)
                                .font(.subheadline)
                        } else {
                            Image(systemName: "arrow.down")
                                .foregroundColor(.red)
                            Text("\(String(format: "%.1f", abs(data.percentageChange)))%")
                                .foregroundColor(.red)
                                .font(.subheadline)
                        }
                    }
                }
                
                Spacer()
                
                lineChartView(pointsData: data.pointsData)
                    .frame(height: 120)
                    .padding(.leading, 10)
            }
            .padding(.bottom, 10)
        }
        .padding()
        .background(Color(hex: "E0E0E0").opacity(0.5))
        .cornerRadius(10)
    }
}

struct lineChartView: View {
    var pointsData: [(String, Double)]

    var body: some View {
        Chart {
            ForEach(pointsData, id: \.0) { (date, points) in
                LineMark(
                    x: .value("Date", date),
                    y: .value("Points", points)
                )
                .foregroundStyle(Color.blue)
            }
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .padding(.trailing)
    }
}

// Fetch the player stats and process them for scoring efficiency
// Fetch the player stats and process them for scoring efficiency
func loadScoringEfficiencyData(from filename: String) -> ScoringEfficiencyData {
    let playerStats = loadPlayerStats1(from: filename)
    
    // Filter data for "Parth"
    let filteredStats = playerStats.filter { $0.name.lowercased() == "parth" }
    
    // Extract points and calculate the points per game and percentage change
    let pointsData = filteredStats.map { stat in
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        
        // Use the TimeInterval (stat.matchDate) directly to create the Date
        let date = stat.matchDate // If stat.matchDate is already a Date
// This is correct
        
        let dateString = dateFormatter.string(from: date)
        return (dateString, Double(stat.points))
    }
    
    // Calculate points per game
    let totalPoints = pointsData.reduce(0) { $0 + $1.1 }
    let pointsPerGame = pointsData.isEmpty ? 0 : totalPoints / Double(pointsData.count)
    
    // Calculate percentage change (comparing the first and last entry)
    guard let firstPoints = pointsData.first?.1, let lastPoints = pointsData.last?.1 else {
        return ScoringEfficiencyData(pointsPerGame: 0, percentageChange: 0, pointsData: pointsData)
    }
    
    let percentageChange = firstPoints == 0 ? 0 : ((lastPoints - firstPoints) / firstPoints) * 100
    
    return ScoringEfficiencyData(pointsPerGame: pointsPerGame, percentageChange: percentageChange, pointsData: pointsData)
}


// Helper function to load player stats from JSON
func loadPlayerStats1(from filename: String) -> [PlayerStats] {
    let fileManager = FileManager.default
    // Get the Documents directory in the current app sandbox
    guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
        print("Failed to get the documents directory URL.")
        return []
    }

    let fileURL = documentsURL.appendingPathComponent(filename)

    // Attempt to load and decode the JSON data
    guard let data = try? Data(contentsOf: fileURL),
          let playerStats = try? JSONDecoder().decode([PlayerStats].self, from: data) else {
        print("Failed to load data from \(fileURL.path)")
        return []
    }
    
    return playerStats
}

struct ScoringEfficiencyView_Previews: PreviewProvider {
    static var previews: some View {
        // Replace static data with dynamic data from JSON
        let scoringEfficiencyData = loadScoringEfficiencyData(from: "playerStats.json")
        ScoringEfficiencyView(data: scoringEfficiencyData)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
