import SwiftUI

struct StatsSummaryView: View {
    var totalPoints: Int = 1260
    var gamesPlayed: Int = 63

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Main heading 'Summary' - centered
            Text("Summary")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .center) // Centering the text

            // Subheading 'Overall Gameplay' - aligned to the leading side
            Text("Overall Gameplay")
                .font(.title2)
                .fontWeight(.semibold)

            // Two containers side by side
            HStack(spacing: 20) {
                StatsContainerView(footer: "Total Points Scored", value: "\(totalPoints)")
                StatsContainerView(footer: "Games Played", value: "\(gamesPlayed)")
            }

            Spacer()
        }
        .padding()
    }
}

// A custom view for each stats container
struct StatsContainerView: View {
    var footer: String
    var value: String

    var body: some View {
        VStack {
            // Value inside the container
            Text(value)
                .font(.largeTitle)
                .fontWeight(.bold)

            // Footer text
            Text(footer)
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.bottom, 5)
        }
        .frame(width: 150, height: 100) // Adjusted height
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
