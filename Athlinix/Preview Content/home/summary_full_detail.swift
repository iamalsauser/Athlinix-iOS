import SwiftUI

struct TorapsStatsView: View {
    var body: some View {
        VStack {
            
            HStack {
                Image(systemName: "chevron.left")
                    .padding()
                Spacer()
                Text("Player wise stats")
                    .font(.headline)
                Spacer()
            }
            .padding(.top, 20)
            
            
            HStack {
                VStack {
                    
                        Image("lakers")
                            .resizable()
                            .scaledToFit()
                        .frame(width: 60, height: 60)
                    Text("Lakers")
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
                    Image("bulls")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                    Text("Bulls")
                        .font(.caption)
                        .foregroundColor(Color(hex: "#FF5116"))
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical)
            
            
            HStack {
                VStack {
                    Text("76ers")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                
                VStack {
                    Text("toraps")
                        .font(.subheadline)
                        .foregroundColor(Color(hex: "#FF5116"))
                    Rectangle()
                        .fill(Color(hex: "#FF5116"))
                        .frame(width: 120, height: 2)
                        .offset(y: -4)
                }
                .frame(maxWidth: .infinity)
                
                VStack {
                    NavigationLink(destination: eStatsView()) {
                                        Text("Stats")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }

                }
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal)
            
            
            HStack {
                Text("Player")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.gray)
                Spacer()
                Text("reb")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.gray)
                Text("ast")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.gray)
                Text("foul")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.gray)
                Text("pts ")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            .padding(.top, 8)
            
            
            List(0..<5) { _ in
                HStack {
                    Text("John Hart")
                    Spacer()
                    Text("45  ")
                    Text("8   ")
                    Text("0  ")
                    Text("10")
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}


extension Color {
    init(hexaa: String) {
        let hexaa = hexaa.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hexaa).scanHexInt64(&int)
        
        let a, r, g, b: UInt64
        switch hexaa.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0) 
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct TorapsStatsView_Previews: PreviewProvider {
    static var previews: some View {
        TorapsStatsView()
    }
}
