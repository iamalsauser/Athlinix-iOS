import SwiftUI

struct homescreenstoryboard: View {
    @State private var selectedTab: String = "home"
    @State private var showingActionSheet = false
    @State private var navigateToCreatePost = false
    @State private var navigateToBasketballMatch = false
    @State private var navigateToCreateTeam = false
    @State private var showApprovalUI = false

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
                    Explore_UIkit()
                        .tabItem {
                            Image(systemName: "globe")
                            Text("Explore")
                        }
                        .tag("explore")
                    
                    // Profile Tab
                    ProfileUIKitController()
                        .tabItem {
                            Image(systemName: "person.fill")
                            Text("Profile")
                        }
                        .tag("profile")
                }
                .accentColor(.blue)
                
                // Floating button above the tab bar
                VStack {
                    Spacer()

                    // Notification Icon Button in the top-right corner
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            showApprovalUI = true
                        }) {
                            Image(systemName: "bell.fill")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.blue)
                                .padding(10)
                                .background(Color(.systemBackground).opacity(0.9))
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                                )
                        }
                        .padding(.top, 30)  // Adds some top padding for spacing
                        .padding(.trailing, 20)  // Adds space from the right edge
                    }

                    // Plus Button at the bottom-right
                    HStack {
                        Spacer()
                        Button(action: {
                            showingActionSheet = true
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.blue)
                                .padding(10)
                                .background(Color(.systemBackground).opacity(0.9))
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                                )
                        }
                        .padding(.bottom, 80) // Adjust the space above the TabView
                        .padding(.trailing, 20) // Position it towards the right corner
                    }
                }
                .actionSheet(isPresented: $showingActionSheet) {
                    ActionSheet(
                        title: Text("Choose an Option"),
                        buttons: [
                            .default(Text("Add Match")) {
                                navigateToBasketballMatch = true
                            },
                            .default(Text("Create Team")) {
                                navigateToCreateTeam = true
                            },
                            .default(Text("Create Post")) {
                                navigateToCreatePost = true
                            },
                            .cancel {
                                print("ActionSheet dismissed")
                            }
                        ]
                    )
                }
                .sheet(isPresented: $showApprovalUI) {
                    approvalui()
                }
                
                // Navigation Links
                NavigationLink(destination: CreatePostView(), isActive: $navigateToCreatePost) { EmptyView() }
                NavigationLink(destination: BasketballMatchTemplate(), isActive: $navigateToBasketballMatch) { EmptyView() }
                NavigationLink(destination: CreateTeamView(), isActive: $navigateToCreateTeam) { EmptyView() }
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    homescreenstoryboard()
}
