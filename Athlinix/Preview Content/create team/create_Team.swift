import SwiftUI

struct CreateTeamView: View {
    @State private var teamName: String = ""
    @State private var city: String = ""
    @State private var coachName: String = ""
    @State private var players: [Player] = []
    @State private var newPlayerName: String = ""
    @State private var newPlayerPosition: String = ""
    @State private var showConfirmation: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Team Details")) {
                    TextField("Team Name", text: $teamName)
                        .autocapitalization(.words)
                        .disableAutocorrection(true)
                    
                    TextField("City", text: $city)
                        .autocapitalization(.words)
                        .disableAutocorrection(true)
                    
                    TextField("Coach Name", text: $coachName)
                        .autocapitalization(.words)
                        .disableAutocorrection(true)
                }
                
                Section(header: Text("Players")) {
                    ForEach(players, id: \.id) { player in
                        HStack {
                            Text(player.name)
                            Spacer()
                            Text(player.position)
                                .foregroundColor(.gray)
                        }
                    }
                    .onDelete(perform: removePlayer)
                    
                    VStack {
                        TextField("Player Name", text: $newPlayerName)
                            .autocapitalization(.words)
                            .disableAutocorrection(true)
                        
                        TextField("Player Position", text: $newPlayerPosition)
                            .autocapitalization(.words)
                            .disableAutocorrection(true)
                        
                        Button(action: addPlayer) {
                            Text("Add Player")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                        .disabled(newPlayerName.isEmpty || newPlayerPosition.isEmpty)
                    }
                }
                
                Section {
                    Button(action: {
                        showConfirmation = true
                    }) {
                        Text("Create Team")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        resetForm()
                    }) {
                        Text("Cancel")
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                }
            }
            .navigationTitle("Create Basketball Team")
            .alert(isPresented: $showConfirmation) {
                Alert(
                    title: Text("Team Created"),
                    message: Text("Your team \(teamName) has been successfully created."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    private func addPlayer() {
        let newPlayer = Player(name: newPlayerName, position: newPlayerPosition)
        players.append(newPlayer)
        newPlayerName = ""
        newPlayerPosition = ""
    }
    
    private func removePlayer(at offsets: IndexSet) {
        players.remove(atOffsets: offsets)
    }
    
    private func resetForm() {
        teamName = ""
        city = ""
        coachName = ""
        players = []
        newPlayerName = ""
        newPlayerPosition = ""
    }
}

struct Player: Identifiable {
    let id = UUID()
    let name: String
    let position: String
}

struct CreateTeamView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTeamView()
    }
}
