import SwiftUI
import Charts

struct ScoringEfficiencyView: View {
    var pointsPerGame: Double
    var percentageChange: Double // Use positive for increase, negative for decrease
    var pointsData: [(String, Double)] // Array of tuples containing (date, points)

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Title
            Text("Scoring Efficiency")
                .font(.headline)
                .foregroundColor(.primary)
                .padding(.bottom, 5)
            
            // HStack for Points per Game and Line Chart
            HStack(alignment: .top) {
                // Points per Game Section
                VStack(alignment: .leading, spacing: 5) {
                    // Points per Game Label
                    Text("Points per Game")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    // Value of points per game
                    Text("\(String(format: "%.1f", pointsPerGame))")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    // Percentage change with arrow
                    HStack(spacing: 5) {
                        if percentageChange > 0 {
                            Image(systemName: "arrow.up")
                                .foregroundColor(.green)
                            Text("\(String(format: "%.1f", percentageChange))%")
                                .foregroundColor(.green)
                                .font(.subheadline)
                        } else {
                            Image(systemName: "arrow.down")
                                .foregroundColor(.red)
                            Text("\(String(format: "%.1f", abs(percentageChange)))%")
                                .foregroundColor(.red)
                                .font(.subheadline)
                        }
                    }
                }
                
                Spacer()
                
                // Line Chart Section
                lineChartView(pointsData: pointsData)
                    .frame(height: 120) // Adjusted height for balance
                    .padding(.leading, 10) // Padding to space out from the text
            }
            .padding(.bottom, 10)
        }
        .padding()
        .background(Color(hex: "E0E0E0").opacity(0.5)) // Background color with slight transparency
        .cornerRadius(10)
//        .shadow(radius: 5)
    }
}

// Line Chart View
struct lineChartView: View {
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
        .padding(.trailing) // Padding to adjust the chart inside the container
    }
}

// Preview
struct ScoringEfficiencyView_Previews: PreviewProvider {
    static var previews: some View {
        // Sample data for the chart
        let sampleData: [(String, Double)] = [
            ("Oct 1", 20),
            ("Oct 2", 24),
            ("Oct 3", 22),
            ("Oct 4", 30),
            ("Oct 5", 28)
        ]
        
        ScoringEfficiencyView(pointsPerGame: 24.3, percentageChange: 3.5, pointsData: sampleData)
            .previewLayout(.sizeThatFits)
            .padding()
        
        ScoringEfficiencyView(pointsPerGame: 18.7, percentageChange: -1.2, pointsData: sampleData)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
