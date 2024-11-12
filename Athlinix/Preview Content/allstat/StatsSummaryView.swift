import SwiftUI

struct StatsSummaryView: View {
    var totalPoints: Int = 1260
    var gamesPlayed: Int = 63

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Summary")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .center)

            Text("Overall Gameplay")
                .font(.title2)
                .fontWeight(.semibold)

            HStack(spacing: 20) {
                StatsContainerView(footer: "Total Points Scored", value: "\(totalPoints)")
                StatsContainerView(footer: "Games Played", value: "\(gamesPlayed)")
            }

            Spacer()
        }
        .padding()
    }
}

struct StatsContainerView: View {
    var footer: String
    var value: String

    var body: some View {
        VStack {
            Text(value)
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(footer)
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.bottom, 5)
        }
        .frame(width: 150, height: 100)
        .background(Color.white)
        .cornerRadius(20).opacity(5)
        .shadow(radius: 1)
    }
}

struct StatsSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        StatsSummaryView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
