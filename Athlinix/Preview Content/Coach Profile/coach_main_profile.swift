import SwiftUI
import UIKit

struct cProfileStat: View {
    @Binding var selectedButton: String
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ScrollView {
                    VStack {
                        NavigationLink(destination: Cert_template()) {
                            cProfileView()}
                        cProfileInfoView()
                        cStatsView()
                        Spacer()
                        Spacer()
                        cTeamsView()
                        Spacer()
                        cAllMatchesListbest()
                        Spacer()
                        cSocialMediaFeedView()
                    }
                    .padding(.bottom, 60)
                }
            }
            .background(Color(.systemGray6))
            .navigationBarHidden(true)
        }
    }
}

struct cProfile_Previews: PreviewProvider {
    static var previews: some View {
        cProfileStat(selectedButton: .constant("profile"))
    }
}
