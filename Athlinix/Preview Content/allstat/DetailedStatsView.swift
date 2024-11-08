import SwiftUI
import Charts

struct DetailedStatsView: View {
    var chartData1: [(String, Double)]
    var chartData2: [(String, Double)]
    
    var body: some View {
        HStack(spacing: 20) {
            // First container with a horizontal chart and stats
            StatsContainerViews(chartData: chartData1, title: "Assist", value: 10.42, percentageChange: 5.0, footer: "")
                .frame(maxWidth: .infinity)
            
            // Second container with another horizontal chart and stats
            StatsContainerViews(chartData: chartData2, title: "Rebounds", value: 13.7, percentageChange: 2.3, footer: "")
                .frame(maxWidth: .infinity)
        }
        .padding()
    }
}

struct StatsContainerViews: View {
    var chartData: [(String, Double)]
    var title: String
    var value: Double
    var percentageChange: Double
    var footer: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            
            HStack(alignment: .top, spacing: 10) {
                // Stats section on the left
                VStack(alignment: .leading, spacing: 5) {
                    // Value display
                    Text("\(String(format: "%.1f", value))")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    // Percentage change with smaller arrow and text
                    HStack(spacing: 3) {
                        if percentageChange > 0 {
                            Image(systemName: "arrow.up")
                                .foregroundColor(.green)
                                .font(.system(size: 10)) // Smaller arrow size
                            Text("\(String(format: "%.1f", percentageChange))%")
                                .foregroundColor(.green)
                                .font(.system(size: 12)) // Smaller text size
                        } else {
                            Image(systemName: "arrow.down")
                                .foregroundColor(.green)
                                .font(.system(size: 10)) // Smaller arrow size
                            Text("\(String(format: "%.1f", abs(percentageChange)))%")
                                .foregroundColor(.red)
                                .font(.system(size: 12)) // Smaller text size
                        }
                    }
                    
                    // Footer text
                    Text(footer)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                // Chart section on the right
                lineChartViews(pointsData: chartData)
                    .frame(height: 80) // Reduced height to keep it compact
                    .padding(.leading, 10)
            }
        }
        .padding()
        .background(Color(hex: "E0E0E0").opacity(0.5))
        .cornerRadius(10)
//        .shadow(radius: 5)
    }
}

// Line Chart View
struct lineChartViews: View {
    var pointsData: [(String, Double)]

    var body: some View {
        Chart {
            ForEach(pointsData, id: \.0) { (date, points) in
                LineMark(
                    x: .value("Date", date),
                    y: .value("Points", points)
                )
                .foregroundStyle(Color.blue)
            }
        }
        .chartXAxis(.hidden) // Hide x-axis
        .chartYAxis(.hidden) // Hide y-axis
    }
}

// Preview
struct DetailedStatsView_Previews: PreviewProvider {
    static var previews: some View {
        // Adjusted data for Assist to show upward trend
        let sampleData1: [(String, Double)] = [
            ("Oct 1", 10), ("Oct 2", 15), ("Oct 3", 20), ("Oct 4", 25), ("Oct 5", 30)
        ]
        
        // Adjusted data for Rebounds to show downward trend
        let sampleData2: [(String, Double)] = [
            ("Oct 1", 30), ("Oct 2", 25), ("Oct 3", 20), ("Oct 4", 15), ("Oct 5", 10)
        ]
        
        DetailedStatsView(chartData1: sampleData1, chartData2: sampleData2)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
