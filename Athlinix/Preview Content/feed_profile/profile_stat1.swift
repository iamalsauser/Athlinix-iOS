import SwiftUI

struct StatsView1: View {
    let stats: [Stat1] = [
        Stat1(title: "Position", value: "PF"),
        Stat1(title: "Matches", value: "24"),
        Stat1(title: "Height", value: "6'11\""),
        Stat1(title: "Weight", value: "265 lbs")
    ]
    
    let performanceStats: [Stat1] = [
        Stat1(title: "PPG", value: "17.8"),
        Stat1(title: "BPG", value: "3.4"),
        Stat1(title: "AST", value: "9")
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 10) {
                ForEach(stats) { stat1 in
                    StatItemp1(title: stat1.title, value: stat1.value)
                }
            }
            .padding(.horizontal)
            
            HStack(spacing: 20) {
                ForEach(performanceStats) { stat in
                    StatItemp1(title: stat.title, value: stat.value)
                        .frame(maxWidth: 80)
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
        .background(Color(.systemGroupedBackground))
        .cornerRadius(20)
    }
}

struct StatItemp1: View {
    let title: String
    let value: String
    
    @State private var isTapped = false
    
    var body: some View {
        VStack(spacing: 5) {
            Text(value)
                .font(.system(size: 13, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
            Text(title)
                .foregroundColor(.secondary)
                .font(.system(size: 14, weight: .medium))
                .accessibilityLabel("\(title): \(value)")
        }
        .frame(maxWidth: .infinity)
        .frame(minHeight: 50)
        .padding(10)
        .background(isTapped ? Color.blue.opacity(0.1) : Color(.white))
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.1), radius: 3, x: 0, y: 1)
        .onTapGesture {
            isTapped.toggle()
            print("\(title) tapped")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                isTapped.toggle()
            }
        }
    }
}

struct Stat1: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let value: String
}

struct StatsView_Previews1: PreviewProvider {
    static var previews: some View {
        StatsView1()
            .padding()
            .previewLayout(.sizeThatFits)
            .background(Color(.systemGray6))
    }
}
