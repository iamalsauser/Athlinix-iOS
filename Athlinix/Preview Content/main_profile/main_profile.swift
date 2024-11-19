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
            .navigationBarHidden(true)
            
            NavigationLink(destination: allmatch_uikit()) {
                Image(systemName: "clock.fill") // Icon representing history or time
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
                    .padding()
            }
            .position(x: geometry.size.width - 30, y: 30)
        }
    }}

struct Profile_Previews1: PreviewProvider {
    static var previews: some View {
        ProfileStat1(selectedButton: .constant("profile"))
    }
}
