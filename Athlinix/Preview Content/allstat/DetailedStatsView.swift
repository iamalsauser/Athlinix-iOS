import SwiftUI
import Charts

// Define the structure for chart data
struct StatsDataModel: Identifiable {
    var id = UUID() // Conforms to Identifiable for List compatibility
    var date: String
    var value: Double
}

// Define the structure for loading player stats from JSON
struct PlayerStatsui: Codable {
    var name: String
    var id: String
    var assists: Int
    var blocks: Int
    var points: Int
    var steals: Int
    var matchDate: Double
    var rebounds: Int
}

struct DetailedStatsView: View {
    @State private var assistData: [StatsDataModel] = []
    @State private var reboundData: [StatsDataModel] = []

    var body: some View {
        HStack(spacing: 20) {
            StatsContainerViews(chartData: assistData, title: "Assist", value: calculateAverage(assistData), percentageChange: calculatePercentageChange(assistData), footer: "")
                .frame(maxWidth: .infinity)
            StatsContainerViews(chartData: reboundData, title: "Rebounds", value: calculateAverage(reboundData), percentageChange: calculatePercentageChange(reboundData), footer: "")
                .frame(maxWidth: .infinity)
        }
        .padding()
        .onAppear {
            loadData()
        }
    }
    
    func loadData() {
        let playerStats = loadPlayerStats(from: "playerStats")
        
        // Filter data for "Parth" and convert it
        let filteredStats = playerStats.filter { $0.name.lowercased() == "parth" }
        
        // Convert assist and rebound data
        assistData = convertToStatsDataModel(from: filteredStats, key: \.assists)
        reboundData = convertToStatsDataModel(from: filteredStats, key: \.rebounds)
    }
    
    // Helper function to calculate average value
    func calculateAverage(_ data: [StatsDataModel]) -> Double {
        let total = data.reduce(0) { $0 + $1.value }
        return data.isEmpty ? 0 : total / Double(data.count)
    }
    
    // Helper function to calculate percentage change
    func calculatePercentageChange(_ data: [StatsDataModel]) -> Double {
        guard let first = data.first?.value, let last = data.last?.value, first != 0 else { return 0 }
        return ((last - first) / first) * 100
    }
}

// Helper function for loading player stats from JSON
func loadPlayerStats(from filename: String) -> [PlayerStatsui] {
    let fileManager = FileManager.default
    // Get the Documents directory in the current app sandbox
    let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    let fileURL = documentsURL.appendingPathComponent("\(filename).json")
    
    // Attempt to load and decode the JSON data
    guard let data = try? Data(contentsOf: fileURL),
          let playerStats = try? JSONDecoder().decode([PlayerStatsui].self, from: data) else {
        print("Failed to load data from \(fileURL.path)")
        return []
    }
    return playerStats
}

func convertToStatsDataModel(from stats: [PlayerStatsui], key: KeyPath<PlayerStatsui, Int>) -> [StatsDataModel] {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d"
    
    return stats.map { stat in
        // Convert matchDate (Double) to Date
        let date = Date(timeIntervalSince1970: stat.matchDate)
        let dateString = dateFormatter.string(from: date)
        return StatsDataModel(date: dateString, value: Double(stat[keyPath: key]))
    }
}

// Helper function for saving player stats to JSON
func savePlayerStats(_ stats: [PlayerStatsui], to filename: String) {
    let fileManager = FileManager.default
    let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    let fileURL = documentsURL.appendingPathComponent("\(filename).json")
    
    // Encode and save the data
    if let data = try? JSONEncoder().encode(stats) {
        do {
            try data.write(to: fileURL)
            print("Saved player stats to \(fileURL.path)")
        } catch {
            print("Failed to save data: \(error.localizedDescription)")
        }
    }
}

struct StatsContainerViews: View {
    var chartData: [StatsDataModel]
    var title: String
    var value: Double
    var percentageChange: Double
    var footer: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            
            HStack(alignment: .top, spacing: 10) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(String(format: "%.1f", value))")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    HStack(spacing: 3) {
                        if percentageChange > 0 {
                            Image(systemName: "arrow.up")
                                .foregroundColor(.green)
                                .font(.system(size: 10))
                            Text("\(String(format: "%.1f", percentageChange))%")
                                .foregroundColor(.green)
                                .font(.system(size: 12))
                        } else {
                            Image(systemName: "arrow.down")
                                .foregroundColor(.red)
                                .font(.system(size: 10))
                            Text("\(String(format: "%.1f", abs(percentageChange)))%")
                                .foregroundColor(.red)
                                .font(.system(size: 12))
                        }
                    }
                    
                    Text(footer)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                lineChartViews(pointsData: chartData)
                    .frame(height: 80)
                    .padding(.leading, 10)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10)
    }
}

struct lineChartViews: View {
    var pointsData: [StatsDataModel]

    var body: some View {
        Chart {
            ForEach(pointsData, id: \.id) { data in
                LineMark(
                    x: .value("Date", data.date),
                    y: .value("Value", data.value)
                )
                .foregroundStyle(Color.blue)
            }
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
    }
}

struct DetailedStatsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedStatsView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
