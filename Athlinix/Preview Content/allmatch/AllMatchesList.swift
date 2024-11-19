// AllMatchesList.swift

import SwiftUI

struct AllMatchesList: View {
    
    // Sample matches data
    let matches: [Match] = [
        Match(teamA: "Lakers", teamB: "Bulls", scoreA: 110, scoreB: 105, date: "Oct 13, 2024", team1Stats: MatchStats(fieldGoals: 25, threePFieldGoals: 10, freeThrows: 15), team2Stats: MatchStats(fieldGoals: 20, threePFieldGoals: 8, freeThrows: 12)),
        Match(teamA: "Warriors", teamB: "Celtics", scoreA: 98, scoreB: 110, date: "Oct 12, 2024", team1Stats: MatchStats(fieldGoals: 30, threePFieldGoals: 12, freeThrows: 18), team2Stats: MatchStats(fieldGoals: 25, threePFieldGoals: 15, freeThrows: 20)),
        Match(teamA: "Spurs", teamB: "Heat", scoreA: 105, scoreB: 100, date: "Oct 11, 2024", team1Stats: MatchStats(fieldGoals: 27, threePFieldGoals: 9, freeThrows: 14), team2Stats: MatchStats(fieldGoals: 23, threePFieldGoals: 11, freeThrows: 13)),
        Match(teamA: "Nuggets", teamB: "Mavericks", scoreA: 115, scoreB: 112, date: "Oct 10, 2024", team1Stats: MatchStats(fieldGoals: 28, threePFieldGoals: 11, freeThrows: 20), team2Stats: MatchStats(fieldGoals: 26, threePFieldGoals: 10, freeThrows: 16)),
        Match(teamA: "Suns", teamB: "Knicks", scoreA: 102, scoreB: 97, date: "Oct 9, 2024", team1Stats: MatchStats(fieldGoals: 22, threePFieldGoals: 8, freeThrows: 12), team2Stats: MatchStats(fieldGoals: 20, threePFieldGoals: 9, freeThrows: 15))
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
        .navigationTitle("Match Summaries")
    }
}

struct AllMatchesList_Previews: PreviewProvider {
    static var previews: some View {
        AllMatchesList()
    }
}
