import SwiftUI
import Charts

struct ScoreData1: Identifiable {
    var id = UUID()
    var period: String
    var points: Double
}

struct ScoreDataCollection {
    let monthly: [ScoreData1]
    let weekly: [ScoreData1]
    let annual: [ScoreData1]

    static let sampleData = ScoreDataCollection(
        monthly: [
            ScoreData1(period: "Jan", points: 150),
            ScoreData1(period: "Feb", points: 170),
            ScoreData1(period: "Mar", points: 120),
            ScoreData1(period: "Apr", points: 200),
            ScoreData1(period: "May", points: 180),
            ScoreData1(period: "Jun", points: 220),
            ScoreData1(period: "Jul", points: 195),
            ScoreData1(period: "Aug", points: 170),
            ScoreData1(period: "Sep", points: 210),
            ScoreData1(period: "Oct", points: 230),
            ScoreData1(period: "Nov", points: 190),
            ScoreData1(period: "Dec", points: 250)
        ],
        weekly: [
            ScoreData1(period: "Week 1", points: 50),
            ScoreData1(period: "Week 2", points: 70),
            ScoreData1(period: "Week 3", points: 100),
            ScoreData1(period: "Week 4", points: 80)
        ],
        annual: [
            ScoreData1(period: "2021", points: 1800),
            ScoreData1(period: "2022", points: 2100),
            ScoreData1(period: "2023", points: 2000)
        ]
    )
}

struct BarChartViewstat: View {
    @Binding var selectedOption: String
    private let scoreData = ScoreDataCollection.sampleData

    var body: some View {
        let data: [ScoreData1]
        let yAxisRange: ClosedRange<Double>
        let yAxisStride: Double

        switch selectedOption {
        case "Monthly":
            data = scoreData.monthly
            yAxisRange = 0...250
            yAxisStride = 50
        case "Weekly":
            data = scoreData.weekly
            yAxisRange = 0...100
            yAxisStride = 20
        case "Annual":
            data = scoreData.annual
            yAxisRange = 0...2500
            yAxisStride = 500
        default:
            data = []
            yAxisRange = 0...250
            yAxisStride = 50
        }

        return Chart(data) { item in
            BarMark(
                x: .value("Period", item.period),
                y: .value("Points", item.points)
            )
            .foregroundStyle(Color(red: 253/255, green: 100/255, blue: 48/255))
        }
        .chartYAxis {
            AxisMarks(values: .stride(by: yAxisStride))
        }
        .chartXAxis {
            AxisMarks(values: .automatic)
        }
        .chartYScale(domain: yAxisRange)
        .frame(height: 200)
    }
}

struct BarChartViewstat_Previews: PreviewProvider {
    @State static var selectedOption = "Monthly"

    static var previews: some View {
        BarChartViewstat(selectedOption: $selectedOption)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
