import SwiftUI

struct PlayerStats: Identifiable, Codable {
    var id = UUID()
    var name: String
    var points: Int
    var rebounds: Int
    var assists: Int
    var steals: Int
    var blocks: Int
    var matchDate: Date
}

struct BasketballMatchTemplate: View {
    @State private var matchDate = Date()
    @State private var playerName = ""
    @State private var points = ""
    @State private var rebounds = ""
    @State private var assists = ""
    @State private var steals = ""
    @State private var blocks = ""
    
    @State private var playerStats: [PlayerStats] = []
    @State private var selectedView: Int = 0
    @State private var startDate = Date().addingTimeInterval(-30 * 24 * 60 * 60) // Default to last 30 days
    @State private var endDate = Date()
    @State private var isStatsViewPresented = false // Added this line to fix the error
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Match Details")) {
                    DatePicker("Match Date", selection: $matchDate, displayedComponents: .date)
                    TextField("Player Name", text: $playerName)
                }
                
                Section(header: Text("Enter Your Stats")) {
                    TextField("Points", text: $points).keyboardType(.numberPad)
                    TextField("Rebounds", text: $rebounds).keyboardType(.numberPad)
                    TextField("Assists", text: $assists).keyboardType(.numberPad)
                    TextField("Steals", text: $steals).keyboardType(.numberPad)
                    TextField("Blocks", text: $blocks).keyboardType(.numberPad)
                    
                    Button(action: submitStats) {
                        Text("Submit Stats")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 0.99, green: 0.39, blue: 0.19))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                
                Button(action: viewAllPlayerStats) {
                    Text("View All Player Stats")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                if !playerStats.isEmpty {
                    Section(header: Text("Your Stats Summary")) {
                        ForEach(filteredStats(), id: \.id) { stats in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(stats.name)
                                    .font(.headline)
                                
                                HStack {
                                    Image(systemName: "calendar")
                                    Text("Match Date: \(formatDate(stats.matchDate))")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                Divider().padding(.vertical, 4)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    statRow(title: "Points", value: stats.points)
                                    statRow(title: "Rebounds", value: stats.rebounds)
                                    statRow(title: "Assists", value: stats.assists)
                                    statRow(title: "Steals", value: stats.steals)
                                    statRow(title: "Blocks", value: stats.blocks)
                                }
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
            .navigationTitle("Your Match Stats")
            .onAppear(perform: loadPlayerStats)
            .sheet(isPresented: $isStatsViewPresented) {
                AllPlayerStatsView(stats: $playerStats)
            }
        }
    }
    
    private func statRow(title: String, value: Int) -> some View {
        HStack {
            Text("\(title):").foregroundColor(.secondary)
            Spacer()
            Text("\(value)").foregroundColor(.primary)
        }
    }
    
    private func createPlayerStats() -> PlayerStats? {
        guard let points = Int(points),
              let rebounds = Int(rebounds),
              let assists = Int(assists),
              let steals = Int(steals),
              let blocks = Int(blocks),
              !playerName.isEmpty else { return nil }
        
        return PlayerStats(name: playerName, points: points, rebounds: rebounds, assists: assists, steals: steals, blocks: blocks, matchDate: matchDate)
    }
    
    private func submitStats() {
        if let stats = createPlayerStats() {
            playerStats.append(stats)
            savePlayerStats(stats)
            resetInputFields()
        } else {
            print("Failed to create PlayerStats")
        }
    }

    private func resetInputFields() {
        playerName = ""
        points = ""
        rebounds = ""
        assists = ""
        steals = ""
        blocks = ""
        matchDate = Date()
    }
    
    private func savePlayerStats(_ stats: PlayerStats) {
        var allStats = loadAllPlayerStats()
        allStats.append(stats)
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let encoded = try? encoder.encode(allStats) {
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = documentsDirectory.appendingPathComponent("playerStats.json")
                do {
                    try encoded.write(to: fileURL)
                    print("Saved player stats to \(fileURL)")
                } catch {
                    print("Error writing player stats to file: \(error)")
                }
            }
        }
    }

    private func loadAllPlayerStats() -> [PlayerStats] {
        let decoder = JSONDecoder()
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentsDirectory.appendingPathComponent("playerStats.json")
            do {
                let data = try Data(contentsOf: fileURL)
                let stats = try decoder.decode([PlayerStats].self, from: data)
                return stats
            } catch {
                print("Error loading player stats from file: \(error)")
            }
        }
        return []
    }

    private func loadPlayerStats() {
        playerStats = loadAllPlayerStats()
    }
    
    private func filteredStats() -> [PlayerStats] {
        switch selectedView {
        case 0: return playerStats.sorted { $0.matchDate > $1.matchDate }
        case 1: return playerStats.sorted { $0.points > $1.points }
        case 2: return playerStats.filter { $0.matchDate >= startDate && $0.matchDate <= endDate }
        default: return playerStats
        }
    }

    private func viewAllPlayerStats() {
        isStatsViewPresented.toggle()
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct AllPlayerStatsView: View {
    @Binding var stats: [PlayerStats]
    @State private var selectedView = 0
    @State private var startDate = Date().addingTimeInterval(-30 * 24 * 60 * 60)
    @State private var endDate = Date()
    
    var body: some View {
        VStack {
            Picker("View", selection: $selectedView) {
                Text("Recent Matches").tag(0)
                Text("Top Performances").tag(1)
                Text("Date Range").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            if selectedView == 2 {
                DatePicker("From", selection: $startDate, displayedComponents: .date)
                DatePicker("To", selection: $endDate, displayedComponents: .date)
            }

            List {
                ForEach(filteredStats(), id: \.id) { stat in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(stat.name).font(.headline)
                        Text("Date: \(formatDate(stat.matchDate))").font(.subheadline).foregroundColor(.secondary)
                        Text("Points: \(stat.points)")
                        Text("Rebounds: \(stat.rebounds)")
                        Text("Assists: \(stat.assists)")
                        Text("Steals: \(stat.steals)")
                        Text("Blocks: \(stat.blocks)")
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
            }
        }
    }
    
    private func filteredStats() -> [PlayerStats] {
        switch selectedView {
        case 0: return stats.sorted { $0.matchDate > $1.matchDate }
        case 1: return stats.sorted { $0.points > $1.points }
        case 2: return stats.filter { $0.matchDate >= startDate && $0.matchDate <= endDate }
        default: return stats
        }
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

//#Preview
struct BasketballMatchTemplate_Previews: PreviewProvider {
    static var previews: some View {
        BasketballMatchTemplate()
    }
}
