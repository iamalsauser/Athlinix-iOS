import SwiftUI

struct HomeScreen: View {
    @Binding var selectedButton: String

    var body: some View {
        ZStack(alignment: .top) {
            ContentView(selectedTab: $selectedButton)

            if selectedButton == "home" {
                HeaderView()
                    .padding(.top, 60)
                    .ignoresSafeArea(edges: .top)
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            selectedButton = "home"
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

                        NavigationLink(destination: AllStatsViewstat()) {
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
                        teamA: "Lakers",
                        teamB: "Spurs",
                        scoreA: 110,
                        scoreB: 105,
                        date: "Oct 13, 2024",
                        team1Stats: MatchStats(fieldGoals: 25, threePFieldGoals: 10, freeThrows: 15),
                        team2Stats: MatchStats(fieldGoals: 20, threePFieldGoals: 8, freeThrows: 12)
                    )
                    .padding(.horizontal)

                    ImageViewer(imageName: "highlight", matchDetails: "Lakers vs BFI, Miami")
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
            
            ProfileStat(selectedButton: $selectedTab)
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
    static var previews: some View {
        HomeScreen(selectedButton: .constant("home"))
    }
}
