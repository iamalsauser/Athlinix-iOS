import SwiftUI

// Define PlayerStats structure for individual player stats
struct PlayerStats: Identifiable, Codable {
    var id = UUID()
    var name: String
    var points: Int
    var rebounds: Int
    var assists: Int
    var steals: Int
    var blocks: Int
    var matchDate: Date // Added to store the match date and time
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

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Match Details")) {
                    DatePicker("Match Date", selection: $matchDate, displayedComponents: .date)
                    TextField("Player Name", text: $playerName)
                }
                
                Section(header: Text("Enter Your Stats")) {
                    TextField("Points", text: $points)
                        .keyboardType(.numberPad)
                    TextField("Rebounds", text: $rebounds)
                        .keyboardType(.numberPad)
                    TextField("Assists", text: $assists)
                        .keyboardType(.numberPad)
                    TextField("Steals", text: $steals)
                        .keyboardType(.numberPad)
                    TextField("Blocks", text: $blocks)
                        .keyboardType(.numberPad)
                    
                    Button(action: submitStats) {
                        Text("Submit Stats")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 253 / 255, green: 100 / 255, blue: 48 / 255))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                
                // Display the stats summary for all submitted stats
                if !playerStats.isEmpty {
                    Section(header: Text("Your Stats Summary")) {
                        ForEach(playerStats) { stats in
                            VStack(alignment: .leading) {
                                Text(stats.name)
                                    .font(.headline)
                                Text("Match Date: \(formatDate(stats.matchDate))")
                                Text("Points: \(stats.points)")
                                Text("Rebounds: \(stats.rebounds)")
                                Text("Assists: \(stats.assists)")
                                Text("Steals: \(stats.steals)")
                                Text("Blocks: \(stats.blocks)")
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
                
                // Button to view all player stats in the console
                Button(action: viewAllPlayerStats) {
                    Text("View All Player Stats")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .navigationTitle("Your Match Stats")
            .onAppear(perform: loadPlayerStats) // Load existing stats when view appears
        }
    }
    
    private func createPlayerStats() -> PlayerStats? {
        guard let points = Int(points),
              let rebounds = Int(rebounds),
              let assists = Int(assists),
              let steals = Int(steals),
              let blocks = Int(blocks),
              !playerName.isEmpty else { return nil }
        
        return PlayerStats(name: playerName, points: points, rebounds: rebounds, assists: assists, steals: steals, blocks: blocks, matchDate: matchDate) // Save the match date
    }
    
    private func submitStats() {
        if let stats = createPlayerStats() {
            playerStats.append(stats) // Append the new stats to the list
            savePlayerStats(stats) // Save the stats to the JSON file
            print("Stats submitted and saved: \(stats)") // Debug print
            resetInputFields() // Reset input fields
        } else {
            print("Failed to create PlayerStats") // Debug print if creation fails
        }
    }

    private func resetInputFields() {
        playerName = ""
        points = ""
        rebounds = ""
        assists = ""
        steals = ""
        blocks = ""
        matchDate = Date() // Reset match date to the current date
    }
    
    private func savePlayerStats(_ stats: PlayerStats) {
        var allStats: [PlayerStats] = loadAllPlayerStats() // Load existing stats
        allStats.append(stats) // Append the new stat
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(allStats) {
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = documentsDirectory.appendingPathComponent("playerStats.json")
                do {
                    try encoded.write(to: fileURL) // Save all stats back to the file
                    print("Successfully saved player stats to \(fileURL)") // Debug print
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
                let stats = try decoder.decode([PlayerStats].self, from: data) // Load existing stats
                return stats
            } catch {
                print("Error loading player stats from file: \(error)")
            }
        }
        return [] // Return an empty array if loading fails
    }

    // Function to load player stats when the view appears
    private func loadPlayerStats() {
        playerStats = loadAllPlayerStats() // Load stats and assign to state variable
    }
    
    // Function to view all player stats in the console
    private func viewAllPlayerStats() {
        let allStats = loadAllPlayerStats()
        print("All Player Stats: \(allStats)") // This will print the contents of the JSON file to the console
    }
    
    // Format date to a readable string
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
