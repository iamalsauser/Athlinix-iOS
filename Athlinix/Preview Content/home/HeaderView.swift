import SwiftUI

// HeaderView
struct HeaderView: View {
    @State private var showingActionSheet = false
    @State private var navigateToCreatePost = false
    @State private var navigateToBasketballMatch = false

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("ATHLENIX")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                Spacer()
                
                Button(action: {
                    showingActionSheet = true
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                }
                .actionSheet(isPresented: $showingActionSheet) {
                    ActionSheet(title: Text("Choose an Option"), buttons: [
                        .default(Text("Create Post")) {
                            navigateToCreatePost = true
                        },
                        .default(Text("Basketball Match Template")) {
                            navigateToBasketballMatch = true
                        },
                        .cancel()
                    ])
                }
                
                // NavigationLinks for programmatic navigation
                NavigationLink(destination: CreatePostView(), isActive: $navigateToCreatePost) { EmptyView() }
                NavigationLink(destination: BasketballMatchTemplate(), isActive: $navigateToBasketballMatch) { EmptyView() }
            }
            .padding(.top, 40) // Adjust padding for status bar overlap
            .padding(.horizontal)
            
            HStack {
                Image("profile") // Assuming you have an image named "profile"
                    .resizable()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                
                VStack(alignment: .leading) {
                    Text("PARTH SINH")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.leading, 60)
                        .padding()
                    
                    HStack {
                        StatViewstat(label: "17.8", description: "PPG")
                        StatViewstat(label: "3.4", description: "BPG")
                        StatViewstat(label: "9", description: "AST")
                    }
                    .padding(.leading, 60)
                    .padding(.bottom, 10)
                }
                
                Spacer()
            }
            .padding([.leading, .trailing], 20)
        }
        .frame(maxWidth: .infinity)
        .background(Color(red: 253/255, green: 100/255, blue: 48/255)) // FD6430 color
        .cornerRadius(50)
        .ignoresSafeArea(edges: .top) // Allow the header to extend above the safe area
    }
}

// StatView for displaying PPG, BPG, AST
struct StatViewstat: View {
    var label: String
    var description: String

    var body: some View {
        VStack {
            Text(label)
                .font(.headline)
                .foregroundColor(.white)
            Text(description)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.7))
        }
        .frame(width: 50)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
