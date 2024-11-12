import SwiftUI

struct ProfileStat1: View {
    @Binding var selectedButton: String
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ScrollView {
                    VStack {
                        ProfileView1()
                        ProfileInfoView1()
                        StatsView()
                        Spacer()
                        Spacer()
                        TeamsView1_()
                        Spacer()
                        AllMatchesListbest1()
                        Spacer()
                        SocialMediaFeedView1()
                    }
                    .padding(.bottom, 60)
                }
            }
            .background(Color(.systemGray6))
            .edgesIgnoringSafeArea(.top)
        }
    }
}

struct Profile_Previews1: PreviewProvider {
    static var previews: some View {
        ProfileStat(selectedButton: .constant("profile"))
    }
}
