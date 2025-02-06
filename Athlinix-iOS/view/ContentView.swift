import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                if let stats = viewModel.statistics {
                    Section(header: Text("Statistics")) {
                        // Basic Stats
                        statRow(title: "TP", value: stats.tp)
                        statRow(title: "FGM", value: stats.fgm)
                        statRow(title: "FGA", value: stats.fga)
                        statRow(title: "TPM", value: stats.tpm)
                        statRow(title: "TPA", value: stats.tpa)
                        statRow(title: "3PM", value: stats.threepm)
                        statRow(title: "3PA", value: stats.threepa)
                        statRow(title: "FTM", value: stats.ftm)
                        statRow(title: "FTA", value: stats.fta)
                        statRow(title: "OREB", value: stats.oreb)
                        statRow(title: "DREB", value: stats.dreb)
                        statRow(title: "AST", value: stats.ast)
                        statRow(title: "TO", value: stats.to)
                        statRow(title: "STL", value: stats.stl)
                        statRow(title: "PF", value: stats.pf)
                        statRow(title: "BLK", value: stats.blk)
                        
                        // Percentage Stats
                        statRow(title: "FGP", value: "\(stats.fgp?.rounded(toPlaces: 1) ?? 0)%")
                        statRow(title: "3PP", value: "\(stats.threepp?.rounded(toPlaces: 1) ?? 0)%")
                        statRow(title: "FTP", value: "\(stats.ftp?.rounded(toPlaces: 1) ?? 0)%")
                        statRow(title: "TPP", value: "\(stats.tpp?.rounded(toPlaces: 1) ?? 0)%")
                        statRow(title: "EFGP", value: "\(stats.efgp?.rounded(toPlaces: 1) ?? 0)%")
                        statRow(title: "TSP", value: "\(stats.tsp?.rounded(toPlaces: 1) ?? 0)%")
                        statRow(title: "TOP", value: "\(stats.top?.rounded(toPlaces: 1) ?? 0)%")
                        
                        
                        HStack {
                            Text("Complete")
                            Spacer()
                            Image(systemName: stats.isComplete ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(stats.isComplete ? .green : .secondary)
                        }
                    }
                } else {
                    Text("No statistics available.")
                }
            }
            .navigationTitle("Statistics")
            .toolbar {
                if viewModel.isAuthenticated {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            Task {
                                try await viewModel.signOut()
                                await viewModel.isUserAuthenticated()
                            }
                        } label: {
                            Text("Sign Out")
                        }
                    }
                    
                    ToolbarItem {
                        NavigationLink {
                            StatsAddView(viewModel: viewModel)
                        } label: {
                            Label("Add Stats", systemImage: "plus")
                        }
                    }
                } else {
                    ToolbarItem {
                        Button {
                            viewModel.showingAuthView.toggle()
                        } label: {
                            Label("Authenticate", systemImage: "person.crop.circle")
                        }
                    }
                }
            }
            .task {
                try? await viewModel.fetchStatistics()
            }
            .task {
                await viewModel.isUserAuthenticated()
            }
            .sheet(isPresented: $viewModel.showingAuthView) {
                Task { await viewModel.isUserAuthenticated() }
            } content: {
                AuthView(viewModel: viewModel)
            }
        }
    }
    
    // Helper function to display integer stats
    @ViewBuilder
    func statRow(title: String, value: Int) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text("\(value)")
        }
    }
    
    
    @ViewBuilder
    func statRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
        }
    }
}


extension Float {
    func rounded(toPlaces places: Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
