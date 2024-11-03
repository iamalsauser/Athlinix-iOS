import SwiftUI

struct PlayerStats: Identifiable {
    var id = UUID()
    var name: String
    var points: Int
    var rebounds: Int
    var assists: Int
    var steals: Int
    var blocks: Int
}

struct BasketballMatchTemplate: View {
    @State private var matchDate = Date()
    @State private var teamName = ""
    @State private var players: [PlayerStats] = []
    @State private var newPlayerName = ""
    @State private var newPlayerPoints = ""
    @State private var newPlayerRebounds = ""
    @State private var newPlayerAssists = ""
    @State private var newPlayerSteals = ""
    @State private var newPlayerBlocks = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Match Details")) {
                    DatePicker("Match Date", selection: $matchDate, displayedComponents: .date)
                    TextField("Team Name", text: $teamName)
                }
                
                Section(header: Text("Add Player Stats")) {
                    TextField("Player Name", text: $newPlayerName)
                    TextField("Points", text: $newPlayerPoints)
                        .keyboardType(.numberPad)
                    TextField("Rebounds", text: $newPlayerRebounds)
                        .keyboardType(.numberPad)
                    TextField("Assists", text: $newPlayerAssists)
                        .keyboardType(.numberPad)
                    TextField("Steals", text: $newPlayerSteals)
                        .keyboardType(.numberPad)
                    TextField("Blocks", text: $newPlayerBlocks)
                        .keyboardType(.numberPad)
                    
                    Button(action: addPlayer) {
                        Text("Add Player")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 253 / 255, green: 100 / 255, blue: 48 / 255))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                
                Section(header: Text("Player Stats")) {
                    ForEach(players) { player in
                        VStack(alignment: .leading) {
                            Text(player.name)
                                .font(.headline)
                            Text("Points: \(player.points)")
                            Text("Rebounds: \(player.rebounds)")
                            Text("Assists: \(player.assists)")
                            Text("Steals: \(player.steals)")
                            Text("Blocks: \(player.blocks)")
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Progress")        }
    }
    
    private func addPlayer() {
        guard let points = Int(newPlayerPoints),
              let rebounds = Int(newPlayerRebounds),
              let assists = Int(newPlayerAssists),
              let steals = Int(newPlayerSteals),
              let blocks = Int(newPlayerBlocks) else { return }
        
        let newPlayer = PlayerStats(name: newPlayerName, points: points, rebounds: rebounds, assists: assists, steals: steals, blocks: blocks)
        players.append(newPlayer)
        
        // Reset the input fields
        newPlayerName = ""
        newPlayerPoints = ""
        newPlayerRebounds = ""
        newPlayerAssists = ""
        newPlayerSteals = ""
        newPlayerBlocks = ""
    }
}

#Preview {
    BasketballMatchTemplate()
}
