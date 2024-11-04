import SwiftUI

struct cProfileStat: View {
    @Binding var selectedButton: String // Use binding to track the selected state
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) { // Set spacing to 0 to ensure the views are tightly packed
                
                // Wrap the scrollable content in a ScrollView
                ScrollView {
                    VStack {
                        cProfileView()
                        cProfileInfoView()
                        cStatsView()
                        Spacer()
                        Spacer()
                        cTeamsView()
                        Spacer()
                        cAllMatchesListbest()
                        // Add more views here if needed
                        // Add a spacer to prevent the last view from being too close to the navbar
                        Spacer()
                        cSocialMediaFeedView()
                    }
                    .padding(.bottom, 60) // Padding to avoid overlapping with the navbar
                }
                
                // Add ProfileNavBar at the bottom
//                ProfileNavBar3()
//                    .frame(width: geometry.size.width, height: 60) // Set the width and height of the navbar
//                    .background(Color.white) // Optional: set background color for the navbar
            }
            .background(Color(.systemGray6))
            .navigationBarHidden(true)
//            .edgesIgnoringSafeArea(.top)  Extend to cover the top edge
        }
    }
}

struct cProfile_Previews: PreviewProvider {
    static var previews: some View {
        cProfileStat(selectedButton: .constant("profile")) // Provide a default binding for previews
    }
}
