import SwiftUI

struct LogoScreen: View {
    @State private var selectedButton: String = "home" // Default selected button
    @State private var navigateToHome: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Image("logo") // Replace with your logo image
                    .resizable()
                    .frame(width: 200, height: 150)
                Spacer()
                
                // Navigation link that triggers after 3 seconds
                NavigationLink(destination: CreateAccountScreen(selectedButton: $selectedButton), isActive: $navigateToHome) {
                    EmptyView()
                }
            }
            .navigationTitle("Welcome")
            .navigationBarHidden(true) // Hide the navigation bar if needed
            .onAppear {
                // Wait for 3 seconds, then navigate to the HomeScreen
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    navigateToHome = true
                }
            }
        }
    }
}

struct LogoScreen_Previews: PreviewProvider {
    static var previews: some View {
        LogoScreen() // Preview the LogoScreen
    }
}
