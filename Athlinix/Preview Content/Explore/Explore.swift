import SwiftUI

struct Explore: View {
    @Binding var selectedButton: String // Use binding to track the selected state
    @State private var searchText: String = "" // State variable for the search text
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) { // Ensure no spacing between content and navigation bar
                
                // Custom Navigation Bar with Search Bar
                HStack {
                    // Search bar with magnifying glass icon
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search...", text: $searchText)
                            .foregroundColor(.primary)
                            .padding(7)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    }
                    .padding(.horizontal).padding(.bottom)
                    
                    Spacer()
                }
                .padding(.top) // Add padding to the top if needed for spacing
                
                // Content of Explore Page
                InstagramFeedView() // Feed view integrated
                
                Spacer() // Add spacer to maintain layout balance
                
                // ProfileNavBar at the bottom
//                ProfileNavBar()
//                    .frame(width: geometry.size.width, height: 0) // Set the width and height of the navbar
//                    .background(Color.white).padding(.bottom,60)
            }
            .navigationBarHidden(true) // Hide the default navigation bar
            .edgesIgnoringSafeArea(.bottom) // Extend the view to the bottom edge, covering any white space
        }
    }
}

struct Explore_Previews: PreviewProvider {
    static var previews: some View {
        Explore(selectedButton: .constant("explore")) // Provide a default binding for previews
    }
}
