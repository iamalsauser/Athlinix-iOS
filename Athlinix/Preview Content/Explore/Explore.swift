import SwiftUI

struct Explore: View {
    @Binding var selectedButton: String
    @State private var searchText: String = ""

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                HStack {
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
                .padding(.top)
                
                // Pass searchText to InstagramFeedView
                InstagramFeedView(searchText: searchText)
                
                Spacer()
            }
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct Explore_Previews: PreviewProvider {
    static var previews: some View {
        Explore(selectedButton: .constant("explore"))
    }
}
