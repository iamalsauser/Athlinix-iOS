import SwiftUI
import Charts

struct ScoringEfficiencyView: View {
    var pointsPerGame: Double
    var percentageChange: Double
    var pointsData: [(String, Double)]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Scoring Efficiency")
                .font(.headline)
                .foregroundColor(.primary)
                .padding(.bottom, 5)
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Points per Game")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("\(String(format: "%.1f", pointsPerGame))")
                        .font(.title)
                        .fontWeight(.bold)
                    
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
                
                lineChartView(pointsData: pointsData)
                    .frame(height: 120)
                    .padding(.leading, 10)
            }
            .padding(.bottom, 10)
        }
        .padding()
        .background(Color(hex: "E0E0E0").opacity(0.5))
        .cornerRadius(10)
    }
}

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
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .padding(.trailing)
    }
}

struct ScoringEfficiencyView_Previews: PreviewProvider {
    static var previews: some View {
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
