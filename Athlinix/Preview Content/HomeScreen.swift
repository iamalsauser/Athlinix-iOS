import SwiftUI

struct HomeScreen: View {
    @Binding var selectedButton: String

    @State private var isHeaderTapped = false  // State to track if the header was tapped

    var body: some View {
        ZStack(alignment: .top) {
            ContentView(selectedTab: $selectedButton)

            if selectedButton == "home" {
                HeaderView()
                    .padding(.top, 60)
                    .ignoresSafeArea(edges: .top)
                    .onTapGesture {
                        isHeaderTapped.toggle()  // Toggle the sheet state when HeaderView is tapped
                    }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Ensures NavigationView works with ZStack
        .navigationBarHidden(true)
        .onAppear {
            selectedButton = "home"
        }
        .sheet(isPresented: $isHeaderTapped) {  // Show sheet when the state is true
            teamscreen_uikit()  // Your custom view for the sheet
        }
    }
}

struct ContentView: View {
    @Binding var selectedTab: String

    var body: some View {
        TabView(selection: $selectedTab) {
            ScrollView {
                VStack(spacing: 10) {
                    HStack {
                        Text("Points Scored")
                            .font(.headline)
                            .padding(.leading)

                        Spacer()

                        NavigationLink(destination: AllStatsViewstat()/*analysisuikit()*/) {
                            Text("See All")
                                .foregroundColor(.blue)
                                .padding(.trailing)
                        }
                    }
                    .padding(.top, 220)

                    LineChartView()
                        .frame(height: 200)
                        .padding()

                    HStack {
                        Text("Pinned Matches")
                            .font(.headline)
                            .padding(.leading)

                        Spacer()

                        NavigationLink(destination: AllMatchesList()) {
                            Text("See All")
                                .foregroundColor(.blue)
                                .padding(.trailing)
                        }
                    }
                    .padding(.top, 10)
                    .padding(.horizontal)

                    MatchSummaryViewFormat1(
                        teamA: "Spurs",
                        teamB: "Lakers",
                        scoreA: 110,
                        scoreB: 105,
                        date: "Oct 13, 2024",
                        team1Stats: MatchStats(fieldGoals: 25, threePFieldGoals: 10, freeThrows: 15),
                        team2Stats: MatchStats(fieldGoals: 20, threePFieldGoals: 8, freeThrows: 12)
                    )
                    .padding(.horizontal)

                    ImageViewer(imageName: "highlight", matchDetails: "Lakers vs Cavs, Miami")
                        .padding(.horizontal)
                        .padding(.top, 10)

                    ProfileSliderView()
                        .padding(.top, 10)

                    EnhancedBarChartView()
                        .padding(.top, 50)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            .tag("home")
            
            Explore(selectedButton: $selectedTab)
                .tabItem {
                    Image(systemName: "globe")
                    Text("Explore")
                }
                .tag("explore")
            
            ProfileStat1(selectedButton: $selectedTab)
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag("profile")
        }
        .accentColor(.blue)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    @State static var dummyButton: String = "home"

    static var previews: some View {
        HomeScreen(selectedButton: $dummyButton)
    }
}
