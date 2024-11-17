import SwiftUI
import Charts

struct DetailedStatsView: View {
    var chartData1: [StatsDataModel]
    var chartData2: [StatsDataModel]
    
    var body: some View {
        HStack(spacing: 20) {
            StatsContainerViews(chartData: chartData1, title: "Assist", value: 10.42, percentageChange: 5.0, footer: "")
                .frame(maxWidth: .infinity)
            StatsContainerViews(chartData: chartData2, title: "Rebounds", value: 13.7, percentageChange: 2.3, footer: "")
                .frame(maxWidth: .infinity)
        }
        .padding()
    }
}

struct StatsContainerViews: View {
    var chartData: [StatsDataModel]
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
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(String(format: "%.1f", value))")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    HStack(spacing: 3) {
                        if percentageChange > 0 {
                            Image(systemName: "arrow.up")
                                .foregroundColor(.green)
                                .font(.system(size: 10))
                            Text("\(String(format: "%.1f", percentageChange))%")
                                .foregroundColor(.green)
                                .font(.system(size: 12))
                        } else {
                            Image(systemName: "arrow.down")
                                .foregroundColor(.green)
                                .font(.system(size: 10))
                            Text("\(String(format: "%.1f", abs(percentageChange)))%")
                                .foregroundColor(.red)
                                .font(.system(size: 12))
                        }
                    }
                    
                    Text(footer)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                lineChartViews(pointsData: chartData)
                    .frame(height: 80)
                    .padding(.leading, 10)
            }
        }
        .padding()
        .background(Color(hex: "E0E0E0").opacity(0.5))
        .cornerRadius(10)
    }
}

struct lineChartViews: View {
    var pointsData: [StatsDataModel]

    var body: some View {
        Chart {
            ForEach(pointsData, id: \.date) { data in
                LineMark(
                    x: .value("Date", data.date),
                    y: .value("Value", data.value)
                )
                .foregroundStyle(Color.blue)
            }
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
    }
}

struct DetailedStatsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedStatsView(chartData1: SampleData.assistData, chartData2: SampleData.reboundData)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
