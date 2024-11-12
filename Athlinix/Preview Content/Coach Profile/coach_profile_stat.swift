import SwiftUI

struct cStatsView: View {
    let performanceStats: [Stat] = [
        Stat(title: "Location", value: "Gurgaon"),
        Stat(title: "Matches", value: "24")
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 10) {
            }
            .padding(.horizontal)
            
            HStack(spacing: 20) {
                ForEach(performanceStats) { stat in
                    StatItemp(title: stat.title, value: stat.value)
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

struct cStatItemp: View {
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

struct cStat: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let value: String
}

struct cStatsView_Previews: PreviewProvider {
    static var previews: some View {
        cStatsView()
            .padding()
            .previewLayout(.sizeThatFits)
            .background(Color(.systemGray6))
    }
}
