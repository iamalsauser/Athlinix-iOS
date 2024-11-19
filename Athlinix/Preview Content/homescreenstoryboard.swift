import SwiftUI

struct homescreenstoryboard: View {
    @State private var selectedTab: String = "home" // State to track the selected tab
    @State private var showingActionSheet = false // State to track when the action sheet should appear
    @State private var navigateToCreatePost = false // Navigation state for Create Post
    @State private var navigateToBasketballMatch = false // Navigation state for Basketball Match
    @State private var navigateToCreateTeam = false // Navigation state for Create Team
    
    var body: some View {
        NavigationView {
            ZStack {
                // TabView
                TabView(selection: $selectedTab) {
                    // Home Tab
                    home_uikit()
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Home")
                        }
                        .tag("home")
                    
                    // Explore Tab
                    Explore_UIkit() // You can replace this with your actual Explore view
                        .tabItem {
                            Image(systemName: "globe")
                            Text("Explore")
                        }
                        .tag("explore")
                    
                    // Profile Tab
                    ProfileStat(selectedButton: $selectedTab) // Assuming you have a ProfileStat view
                        .tabItem {
                            Image(systemName: "person.fill")
                            Text("Profile")
                        }
                        .tag("profile")
                }
                .accentColor(.blue) // Optionally set accent color for the selected tab
                
                // Floating button above the tab bar
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            // Show the action sheet when the floating button is pressed
                            showingActionSheet = true
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.orange)
                                .clipShape(Circle())
                                .shadow(radius: 10)
                        }
                        .padding(.bottom, 70) // Adjust the space above the TabView
                        .padding(.trailing, 20) // Position it towards the right corner
                    }
                }
                .actionSheet(isPresented: $showingActionSheet) {
                    ActionSheet(
                        title: Text("Choose an Option"),
                        buttons: [
                            .default(Text("Add Match")) {
                                // Trigger navigation to BasketballMatchTemplate
                                navigateToBasketballMatch = true
                            },
                            .default(Text("Create Team")) {
                                // Trigger navigation to CreateTeamView
                                navigateToCreateTeam = true
                            },
                            .default(Text("Create Post")) {
                                // Trigger navigation to CreatePostView
                                navigateToCreatePost = true
                            },
                            .cancel {
                                // Cancel action
                                print("ActionSheet dismissed")
                            }
                        ]
                    )
                }
                
                // Navigation Links
                NavigationLink(destination: CreatePostView(), isActive: $navigateToCreatePost) { EmptyView() }
                NavigationLink(destination: BasketballMatchTemplate(), isActive: $navigateToBasketballMatch) { EmptyView() }
                NavigationLink(destination: CreateTeamView(), isActive: $navigateToCreateTeam) { EmptyView() }
            }
        }
    }
}

#Preview {
    homescreenstoryboard()
}
