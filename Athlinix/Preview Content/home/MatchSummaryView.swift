import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        var rgb: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgb)
        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}

struct MatchSummaryViewFormat1: View {
    var teamA: String
    var teamB: String
    var scoreA: Int
    var scoreB: Int
    var date: String
    var team1Stats: MatchStats
    var team2Stats: MatchStats

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                VStack(alignment: .leading) {
                    Text("\(teamA) vs \(teamB)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)

                    HStack {
                        Text("Score:")
                            .font(.subheadline)
                        Text("\(scoreA) - \(scoreB)")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(scoreA > scoreB ? .green : .red)
                    }
                    Text(date)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding()
            .background(Color.primary.opacity(0.05))
            .cornerRadius(15)

            VStack(spacing: 20) {
                TeamStatsView(teamName: teamA, stats: team1Stats)
                TeamStatsView(teamName: teamB, stats: team2Stats)
            }
            .padding(.horizontal)

            NavigationLink(destination: TorapsStatsView()) {
                Text("Match Summary Details")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .padding(.top)
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(30)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

struct TeamStatsView: View {
    var teamName: String
    var stats: MatchStats

    var body: some View {
        VStack(alignment: .leading) {
            Text("\(teamName) Stats")
                .font(.headline)
                .foregroundColor(.primary)

            StatItem(title: "Field Goals", value: "\(stats.fieldGoals)")
            StatItem(title: "3-Point Field Goals", value: "\(stats.threePFieldGoals)")
            StatItem(title: "Free Throws", value: "\(stats.freeThrows)")
        }
        .padding()
        .background(Color.primary.opacity(0.05))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

struct StatItem: View {
    var title: String
    var value: String

    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.primary)
            Spacer()
            Text(value)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.primary)
        }
        .padding(10)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(8)
        .shadow(radius: 1)
    }
}

struct MatchSummaryViewFormat1_Previews: PreviewProvider {
    static var previews: some View {
        MatchSummaryViewFormat1(
            teamA: "Lakers",
            teamB: "Bulls",
            scoreA: 110,
            scoreB: 105,
            date: "Oct 13, 2024",
            team1Stats: MatchStats(fieldGoals: 25, threePFieldGoals: 10, freeThrows: 15),
            team2Stats: MatchStats(fieldGoals: 20, threePFieldGoals: 8, freeThrows: 12)
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
