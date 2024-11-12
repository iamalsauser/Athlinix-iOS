import SwiftUI

struct ProfileStat: View {
    @Binding var selectedButton: String
    
    var body: some View {
        GeometryReader { geometry in
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
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileStat(selectedButton: .constant("profile"))
    }
}
