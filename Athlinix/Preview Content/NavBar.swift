//import SwiftUI
//
//struct BottomBarView: View {
//    @State private var selectedButton: String = "home" // Track the selected button
//
//    var body: some View {
//        NavigationView {
//            TabView {
//                NavigationLink(destination: HomeScreen(selectedButton: $selectedButton)) {
//                    Image(systemName: "house.fill")
//                }
//                .tabItem {
//                    Image(systemName: "house.fill")
//                    Text("Home") // Optional, if you still want to keep text
//                }
//
//                NavigationLink(destination: SearchView()) {
//                    Image(systemName: "magnifyingglass")
//                }
//                .tabItem {
//                    Image(systemName: "magnifyingglass")
//                    Text("Search") // Optional
//                }
//
//                NavigationLink(destination: mProfileView()) {
//                    Image(systemName: "person.fill")
//                }
//                .tabItem {
//                    Image(systemName: "person.fill")
//                    Text("Profile") // Optional
//                }
//            }
//            .accentColor(.orange) // Customize the accent color for selected items
//        }
//    }
//}
//
//// HomeScreen with binding
//struct HomeScreen: View {
//    @Binding var selectedButton: String // Use binding to track the selected state
//
//    var body: some View {
//        ZStack(alignment: .top) {
//            // Main Content
//            ScrollView {
//                VStack(spacing: 10) {
//                    // Points Scored Section
//                    HStack {
//                        Text("Points Scored")
//                            .font(.headline)
//                            .padding(.leading)
//
//                        Spacer()
//
//                        NavigationLink(destination: AllStatsViewstat()) {
//                            Text("See All")
//                                .foregroundColor(.blue)
//                                .padding(.trailing)
//                        }
//                    }
//                    .padding(.top, 220) // Adjust top padding as needed
//
//                    // Bar Chart for Points Scored Section
//                    LineChartView()
//                        .frame(height: 200) // Adjusted height for better fit
//                        .padding()
//
//                    // Pinned Matches Section
//                    HStack {
//                        Text("Pinned Matches")
//                            .font(.headline)
//                            .padding(.leading)
//
//                        Spacer()
//
//                        NavigationLink(destination: AllMatchesList()) {
//                            Text("See All")
//                                .foregroundColor(.blue)
//                                .padding(.trailing)
//                        }
//                    }
//                    .padding(.top, 10)
//                    .padding(.horizontal)
//
//                    // Match Summary View (example)
//                    MatchSummaryViewFormat1(
//                        teamA: "Lakers",
//                        teamB: "Spurs",
//                        scoreA: 110,
//                        scoreB: 105,
//                        date: "Oct 13, 2024",
//                        team1Stats: MatchStats(fieldGoals: 25, threePFieldGoals: 10, freeThrows: 15),
//                        team2Stats: MatchStats(fieldGoals: 20, threePFieldGoals: 8, freeThrows: 12)
//                    )
//                    .padding(.horizontal)
//
//                    // ImageViewer
//                    ImageViewer(imageName: "highlight", matchDetails: "Lakers vs BFI, Miami")
//                        .padding(.horizontal)
//                        .padding(.top, 10)
//
//                    // Profile Slider View (example)
//                    ProfileSliderView()
//                        .padding(.top, 10)
//
//                    // Bar Chart View (example)
//                    BarChartView()
//                        .padding(.top, 50)
//                }
//                .padding(.horizontal)
//                .padding(.bottom)
//            }
//
//            // Header Section
//            HeaderView()
//                .padding(.top, 60)
//                .ignoresSafeArea(edges: .top)
//
//            // Custom Navigation Bar at the bottom
//            VStack {
//                Spacer()
//                /*CustomNavBar(selectedButton: $selectedButton).padding(.top, 750)*/ // Pass the binding to the custom nav bar
//            }
//        }
//        .navigationBarHidden(true) // Hide the default nav bar
//        .onAppear {
//            selectedButton = "home" // Set the selected button to home when this screen appears
//        }
//    }
//}
//
//struct HomeScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeScreen(selectedButton: .constant("home")) // Provide a default binding for previews
//    }
//}
//
//// Sample Views for Search and Profile
//struct SearchView: View {
//    var body: some View {
//        Text("Search Screen")
//            .font(.largeTitle)
//            .foregroundColor(.green)
//            .navigationTitle("Search") // Title for the navigation bar
//    }
//}
//
//struct mProfileView: View {
//    var body: some View {
//        Text("Profile Screen")
//            .font(.largeTitle)
//            .foregroundColor(.purple)
//            .navigationTitle("Profile") // Title for the navigation bar
//    }
//}
//
//struct BottomBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        BottomBarView()
//    }
//}
//
//
//
////import SwiftUI
////
////struct CustomNavBar: View {
////    @Binding var selectedButton: String // Use binding to track selected state
////
////    var body: some View {
////        HStack {
////            // Home Button
////            NavigationLink(destination: HomeScreen(selectedButton: $selectedButton)) {
////                VStack {
////                    Image(systemName: "house.fill")
////                        .resizable()
////                        .frame(width: 25, height: 25)
////                        .foregroundColor(selectedButton == "home" ? Color(red: 253/255, green: 100/255, blue: 48/255) : .gray)
////                    Text("Home")
////                        .font(.caption)
////                        .foregroundColor(selectedButton == "home" ? Color(red: 253/255, green: 100/255, blue: 48/255) : .gray)
////                }
////            }
////            .frame(maxWidth: .infinity)
////
////            // Explore Button
////            NavigationLink(destination: Explore(selectedButton: $selectedButton)) {
////                VStack {
////                    Image(systemName: "globe")
////                        .resizable()
////                        .frame(width: 25, height: 25)
////                        .foregroundColor(selectedButton == "explore" ? Color(red: 253/255, green: 100/255, blue: 48/255) : .gray)
////                    Text("Explore")
////                        .font(.caption)
////                        .foregroundColor(selectedButton == "explore" ? Color(red: 253/255, green: 100/255, blue: 48/255) : .gray)
////                }
////            }
////            .frame(maxWidth: .infinity)
////
////            // Profile Button
////            NavigationLink(destination: ProfileStat(selectedButton: $selectedButton)) {
////                VStack {
////                    Image(systemName: "person.fill")
////                        .resizable()
////                        .frame(width: 25, height: 25)
////                        .foregroundColor(selectedButton == "profile" ? Color(red: 253/255, green: 100/255, blue: 48/255) : .gray)
////                    Text("Profile")
////                        .font(.caption)
////                        .foregroundColor(selectedButton == "profile" ? Color(red: 253/255, green: 100/255, blue: 48/255) : .gray)
////                }
////            }
////            .frame(maxWidth: .infinity)
////        }
////        .padding()
////        .background(Color.white)
////        .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: -5) // Slight shadow for navbar
////    }
////}
////
////struct CustomNavBar_Previews: PreviewProvider {
////    static var previews: some View {
////        CustomNavBar(selectedButton: .constant("home")) // Provide a default binding for previews
////            .previewLayout(.sizeThatFits)
////            .padding()
////    }
////}
//
