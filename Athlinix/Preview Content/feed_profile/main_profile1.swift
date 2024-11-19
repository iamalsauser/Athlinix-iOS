import SwiftUI

struct ProfileStat: View {
    @Binding var selectedButton: String
    @State private var isHistoryTapped = false // State to handle the button tap
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    VStack(spacing: 0) {
                        ScrollView {
                            VStack {
                                ProfileView()
                                ProfileInfoView()
                                StatsView()
                                Spacer()
                                Spacer()
                                TeamsView()
                                Spacer()
                                AllMatchesListbest()
                                Spacer()
                                SocialMediaFeedView()
                            }
                            .padding(.bottom, 60)
                        }
                    }
                    .background(Color(.systemGray6))
                    .edgesIgnoringSafeArea(.top)
                    .navigationBarHidden(true)
                    
                    // Top-right button
                    NavigationLink(destination: allmatch_uikit()) {
                        Image(systemName: "clock.fill") // Icon representing history or time
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.white)
                            .padding()
                    }
                    .position(x: geometry.size.width - 30, y: 30) // Position the button in the top-right corner
                }
            }
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileStat(selectedButton: .constant("profile"))
    }
}
