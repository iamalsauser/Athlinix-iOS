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
    @State private var showAllPlayerStats = false

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
                
                Button(action: { showAllPlayerStats = true }) {
                    Text("View All Player Stats")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .sheet(isPresented: $showAllPlayerStats) {
                    AllPlayerStatsView(playerStats: playerStats)
                }
            }
            .navigationTitle("Your Match Stats")
            .onAppear(perform: loadPlayerStats)
        }
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

    private func createPlayerStats() -> PlayerStats? {
        guard let points = Int(points),
              let rebounds = Int(rebounds),
              let assists = Int(assists),
              let steals = Int(steals),
              let blocks = Int(blocks),
              !playerName.isEmpty else { return nil }
        
        return PlayerStats(name: playerName, points: points, rebounds: rebounds, assists: assists, steals: steals, blocks: blocks, matchDate: matchDate)
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
}

struct AllPlayerStatsView: View {
    enum GroupingType: String, CaseIterable {
        case date = "Date"
        case month = "Month"
        case year = "Year"
    }
    
    @State private var selectedGrouping: GroupingType = .date
    @State private var searchText = ""
    @State private var sortOption = "Points"
    
    let playerStats: [PlayerStats]

    var groupedStats: [String: [PlayerStats]] {
        let formatter = DateFormatter()
        
        switch selectedGrouping {
        case .date: formatter.dateFormat = "yyyy-MM-dd"
        case .month: formatter.dateFormat = "yyyy-MM"
        case .year: formatter.dateFormat = "yyyy"
        }
        
        let filteredStats = playerStats.filter {
            searchText.isEmpty || $0.name.localizedCaseInsensitiveContains(searchText)
        }
        
        let sortedStats = filteredStats.sorted {
            switch sortOption {
            case "Points": return $0.points > $1.points
            case "Assists": return $0.assists > $1.assists
            case "Rebounds": return $0.rebounds > $1.rebounds
            default: return true
            }
        }
        
        return Dictionary(grouping: sortedStats) { formatter.string(from: $0.matchDate) }
    }

    var body: some View {
        NavigationView {
            VStack {
                Picker("Grouping", selection: $selectedGrouping) {
                    ForEach(GroupingType.allCases, id: \.self) { grouping in
                        Text(grouping.rawValue).tag(grouping)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                HStack {
                    TextField("Search by Player Name", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Menu("Sort By") {
                        Button("Points") { sortOption = "Points" }
                        Button("Assists") { sortOption = "Assists" }
                        Button("Rebounds") { sortOption = "Rebounds" }
                    }
                    .padding()
                }
                
                List {
                    ForEach(groupedStats.keys.sorted(by: >), id: \.self) { key in
                        Section(header: Text(key)) {
                            ForEach(groupedStats[key] ?? []) { stats in
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(stats.name).font(.headline)
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
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("All Player Stats")
        }
    }
    
    private func statRow(title: String, value: Int) -> some View {
        HStack {
            Text("\(title):").foregroundColor(.secondary)
            Spacer()
            Text("\(value)").foregroundColor(.primary)
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    BasketballMatchTemplate()
}
