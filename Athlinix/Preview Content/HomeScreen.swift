import SwiftUI

struct HomeScreen: View {
    @Binding var selectedButton: String // Use binding to track the selected state

    var body: some View {
        ZStack(alignment: .top) {
            // Main Content
            ScrollView {
                VStack(spacing: 10) {
                    // Points Scored Section
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
                    .padding(.top, 220) // Adjust top padding as needed

                    // Bar Chart for Points Scored Section
                    LineChartView()
                        .frame(height: 200) // Adjusted height for better fit
                        .padding()

                    // Pinned Matches Section
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

                    // Match Summary View (example)
                    
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

                    // ImageViewer
                    ImageViewer(imageName: "highlight", matchDetails: "Lakers vs BFI, Miami")
                        .padding(.horizontal)
                        .padding(.top, 10)

                    // Profile Slider View (example)
                    ProfileSliderView()
                        .padding(.top, 10)

                    // Bar Chart View (example)
                    BarChartView()
                        .padding(.top, 50)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }

            // Header Section
            HeaderView()
                .padding(.top, 60)
                .ignoresSafeArea(edges: .top)

            // Custom Navigation Bar at the bottom
            VStack {
                Spacer()
                /*CustomNavBar(selectedButton: $selectedButton).padding(.top, 750)*/ // Pass the binding to the custom nav bar
            }
        }
        .navigationBarHidden(true) // Hide the default nav bar
        .onAppear {
            selectedButton = "home" // Set the selected button to home when this screen appears
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(selectedButton: .constant("home")) // Provide a default binding for previews
    }
}
