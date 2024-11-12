import SwiftUI

struct bestMatch1: Identifiable {
    let id = UUID()
    let teamA: String
    let teamB: String
    let scoreA: Int
    let scoreB: Int
    let date: String
    let team1Stats: MatchStats
    let team2Stats: MatchStats
}

struct bestMatchStats1 {
    let fieldGoals: Int
    let threePFieldGoals: Int
    let freeThrows: Int
}

struct AllMatchesListbest1: View {
    let matches: [Match] = [
        Match(teamA: "Lakers", teamB: "Bulls", scoreA: 110, scoreB: 105, date: "Oct 13, 2024", team1Stats: MatchStats(fieldGoals: 25, threePFieldGoals: 10, freeThrows: 15), team2Stats: MatchStats(fieldGoals: 20, threePFieldGoals: 8, freeThrows: 12)),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(matches) { match in
                    MatchSummaryViewFormat1(
                        teamA: match.teamA,
                        teamB: match.teamB,
                        scoreA: match.scoreA,
                        scoreB: match.scoreB,
                        date: match.date,
                        team1Stats: match.team1Stats,
                        team2Stats: match.team2Stats
                    )
                }
            }
            .padding()
        }
        .navigationTitle("Home")
    }
}

struct AllMatchesList_Previewsbest1: PreviewProvider {
    static var previews: some View {
        AllMatchesListbest()
    }
}
