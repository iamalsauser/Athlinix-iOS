import SwiftUI

struct cTeamsView: View {
    let teams = ["lakers", "toronto", "spurs1", "warriors"]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                Button(action: {}) {
                    VStack {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.gray)
                        Text("Add Team")
                            .foregroundColor(.gray)
                            .fontWeight(.medium)
                            .font(.caption)
                    }
                    .padding(8)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                }
                
                ForEach(teams, id: \.self) { team in
                    VStack {
                        Image(team)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.blue, lineWidth: 0)
                            )
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        
                        Text(team.capitalized)
                            .foregroundColor(.primary)
                            .fontWeight(.medium)
                            .font(.caption)
                    }
                    .padding(.top, 8)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
        }
        .padding(.top, 20)
        .background(Color(.systemGroupedBackground))
        .cornerRadius(15)
    }
}

struct cTeamsView_Previews: PreviewProvider {
    static var previews: some View {
        TeamsView()
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color(.systemGray6))
    }
}
