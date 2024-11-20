import SwiftUI

struct eStatsView: View {
    var body: some View {
        VStack {
            // Top Bar with centered "Stats" title
            ZStack {}
//                HStack {
//                    Image(systemName: "chevron.left")
//                        .padding()
//                    Spacer()
//                }
//                Text("Stats")
//                    .font(.headline)
//            }
//            .padding(.top, 20)
            
            // Score Header with 16-point padding
            HStack {
                VStack {
                    Image("lakers") // 76ers team logo
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                    Text("76ers")
                        .font(.caption)
                }
                
                Spacer()
                
                Text("60")
                    .font(.system(size: 40, weight: .bold))
                
                Text("VS")
                    .font(.title)
                
                Text("31")
                    .font(.system(size: 40, weight: .bold))
                
                Spacer()
                
                VStack {
                    Image("bulls") // Raptors team logo
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                    Text("Toraps")
                        .font(.caption)
                }
            }
            .padding(.horizontal, 16) // Add horizontal padding of 16 points
            .padding(.vertical)
            
            // Tabs with equal width spacing
            HStack {
                Text("Lakers")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity)
                
                Text("BFI")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity)
                
                VStack {
                    Text("Stats")
                        .font(.subheadline)
                        .foregroundColor(Color(hex: "#FF5116")) // Custom color for selected tab
                    Rectangle()
                        .fill(Color(hex: "#FF5116")) // Orange underline
                        .frame(width: 120, height: 2) // Adjusted width and height
                        .offset(y: -4)
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal)
            
            // Stats rows with 14pt spacing between each row
            VStack(spacing: 30) {
                Divider().colorInvert() // Line divider

                HStack {
                    Text("41")
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text("Field goals")
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text("39")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                HStack {
                    Text("10")
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text("Free throws")
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text("12")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                HStack {
                    Text("13")
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text("3P field goals")
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text("23")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                Divider() // Line divider within grid
                
                HStack {
                    Text("51")
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text("Total Rebounds")
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text("38")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                HStack {
                    Text("21")
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text("Assists")
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text("28")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                HStack {
                    Text("7")
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text("Fouls")
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text("5")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                HStack {
                    Text("1")
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text("Steals")
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text("4")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .padding(.horizontal, 16)
            
            Spacer()
        }.navigationBarHidden(false)
    }
}

struct StatsView_Previewse: PreviewProvider {
    static var previews: some View {
        eStatsView()
    }
}

// Helper for custom color

