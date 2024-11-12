import SwiftUI
import Charts

struct GoalData: Identifiable {
    var id = UUID()
    var category: String
    var points: Double
}

let goalData: [GoalData] = [
    GoalData(category: "2pt Field Goals", points: 850),
    GoalData(category: "3pt Field Goals", points: 550),
    GoalData(category: "Free Throws", points: 210)
]

let totalPoints = goalData.reduce(0) { $0 + $1.points }

struct PieChartViewStat: View {
    var body: some View {
        Chart(goalData) { item in
            SectorMark(
                angle: .value("Points", item.points / totalPoints * 360),
                innerRadius: .ratio(0.5),
                outerRadius: .ratio(1.0)
            )
            .foregroundStyle(by: .value("Category", item.category))
            .annotation(position: .overlay) {
                Text(String(format: "%.1f%%", (item.points / totalPoints) * 100))
                    .font(.caption)
                    .foregroundColor(.white)
            }
        }
        .chartForegroundStyleScale([
            "2pt Field Goals": Color.green,
            "3pt Field Goals": Color.blue,
            "Free Throws": Color.orange
        ])
        .chartLegend(position: .bottom)
        .frame(height: 250)
    }
}

struct AllStatsWithPieChartView: View {
    var body: some View {
        VStack {
            Text("Total Goals - \(Int(totalPoints))")
                .font(.title2)
                .bold()
                .foregroundColor(.primary)
                .padding(.bottom, 10)
            
            PieChartViewStat()
                .padding()
        }
        .padding()
        .background(Color(UIColor.systemBackground).opacity(0.95))
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

struct AllStatsWithPieChartView_Previews: PreviewProvider {
    static var previews: some View {
        AllStatsWithPieChartView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
