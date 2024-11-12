import SwiftUI

struct AllStatsViewstat: View {
    @State private var selectedOption: String = "Monthly"
    var totalPoints = 1260
    var gamesPlayed = 63
    var pointsPerGame = 24.3
    var percentageChange = 3.5

    let sampleData1: [(String, Double)] = [
        ("Game 1", 15),
        ("Game 2", 20),
        ("Game 3", 18),
        ("Game 4", 25),
        ("Game 5", 30)
    ]
    
    let sampleData2: [(String, Double)] = [
        ("Game 1", 10),
        ("Game 2", 25),
        ("Game 3", 20),
        ("Game 4", 15),
        ("Game 5", 30)
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                StatsSummaryView(totalPoints: totalPoints, gamesPlayed: gamesPlayed)
                    .padding(.bottom, 0).padding(.top, 0)

                ScoringEfficiencyView(pointsPerGame: pointsPerGame, percentageChange: percentageChange, pointsData: sampleData1)
                    .padding(.bottom, 0)

                DetailedStatsView(chartData1: sampleData1, chartData2: sampleData2)
                    .padding(.top, 0).padding(.bottom, 0)

                Picker("Select Time Frame", selection: $selectedOption) {
                    Text("Monthly").tag("Monthly")
                    Text("Weekly").tag("Weekly")
                    Text("Annual").tag("Annual")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.vertical)

                BarChartViewstat(selectedOption: $selectedOption)
                    .padding(.bottom)

                AllStatsWithPieChartView()
                    .padding(.bottom).padding(.top)

                Spacer()
            }
            .padding()
        }
    }
}

struct AllStatsViewstat_Previews: PreviewProvider {
    static var previews: some View {
        AllStatsViewstat()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
