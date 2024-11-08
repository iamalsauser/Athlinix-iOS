import SwiftUI
import Charts

// Updated Data Structure for Bar Chart Comparison with Custom Categories
struct ComparisonData: Identifiable {
    var id = UUID()
    var category: String
    var team: String
    var points: Double
}

// Sample data for both teams based on custom categories
let customComparisonData = [
    ComparisonData(category: "Overall MVP", team: "Matches Played", points: 150),
    ComparisonData(category: "Overall MVP", team: "Points Scored", points: 180),
    ComparisonData(category: "Tournaments", team: "Matches Played", points: 170),
    ComparisonData(category: "Tournaments", team: "Points Scored", points: 190),
    ComparisonData(category: "Stand Alone", team: "Matches Played", points: 120),
    ComparisonData(category: "Stand Alone", team: "Points Scored", points: 160)
]

// Custom color dictionary for teams
let teamColors: [String: Color] = [
    "Matches Played": Color(hexColor: "fd6430"),
    "Points Scored": Color(hexColor: "fe8a71")
]

// Helper extension to initialize Color from hex code
extension Color {
    init(hexColor hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.startIndex
        var hexNumber: UInt64 = 0
        
        if scanner.scanHexInt64(&hexNumber) {
            let red = Double((hexNumber >> 16) & 0xFF) / 300.0
            let green = Double((hexNumber >> 8) & 0xFF) / 200.0
            let blue = Double(hexNumber & 0xFF) / 255.0
            self.init(red: red, green: green, blue: blue)
            return
        }
        self.init(white: 0.0) // Default to black if hex fails
    }
}

// Enhanced Bar Chart View with custom colors
struct EnhancedBarChartView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Team Comparison by Category")
                .font(.title2)
                .bold()
                .padding(.bottom, 5)
            
            Chart(customComparisonData) { data in
                BarMark(
                    x: .value("Category", data.category),
                    y: .value("Points", data.points)
                )
                .foregroundStyle(teamColors[data.team, default: Color.gray]) // Explicit type for Color
                .position(by: .value("Team", data.team))
            }
            .chartYAxis {
                AxisMarks(values: .stride(by: 50)) {
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel()
                }
            }
            .chartXAxis {
                AxisMarks(values: .automatic) {
                    AxisValueLabel()
                }
            }
            .chartLegend(position: .top, alignment: .leading)
            .chartPlotStyle { plotArea in
                plotArea
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }
            .frame(height: 350)
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
        .padding()
    }
}

// Preview for EnhancedBarChartView
struct EnhancedBarChartView_Previews: PreviewProvider {
    static var previews: some View {
        EnhancedBarChartView()
    }
}
