import SwiftUI

struct AllStatsViewstat: View {
    @State private var selectedOption: String = "Monthly"
    private let statsData = allStatsDataModel.mockData

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                StatsSummaryView(totalPoints: statsData.totalPoints, gamesPlayed: statsData.gamesPlayed)
                    .padding(.bottom, 0).padding(.top, 0)

                ScoringEfficiencyView(data: ScoringEfficiencyData(
                    pointsPerGame: statsData.pointsPerGame,
                    percentageChange: statsData.percentageChange,
                    pointsData: statsData.sampleData1
                ))
                .padding(.bottom, 0)

                DetailedStatsView(chartData1: SampleData.assistData, chartData2: SampleData.reboundData)
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
