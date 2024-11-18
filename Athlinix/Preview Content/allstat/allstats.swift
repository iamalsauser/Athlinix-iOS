import SwiftUI

struct AllStatsViewstat: View {
    @State private var selectedOption: String = "Monthly"
    @State private var scoringEfficiencyData: ScoringEfficiencyData? = nil // This will hold the data
    private let statsData = allStatsDataModel.mockData

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                StatsSummaryView(totalPoints: statsData.totalPoints, gamesPlayed: statsData.gamesPlayed)
                    .padding(.bottom, 0).padding(.top, 0)

                // Check if scoringEfficiencyData is available, if yes, display it
                if let data = scoringEfficiencyData {
                    ScoringEfficiencyView(data: data)
                        .padding()
                } else {
                    Text("Loading scoring efficiency data...") // Show loading message until data is available
                        .onAppear {
                            // Load the scoring efficiency data when the view appears
                            scoringEfficiencyData = loadScoringEfficiencyData(from: "playerStats.json")
                        }
                }

                DetailedStatsView()
                    .padding(.top, 0)
                    .padding(.bottom, 0)

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
