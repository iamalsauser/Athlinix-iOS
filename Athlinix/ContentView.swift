import SwiftUI

struct LogoScreen: View {
    @State private var navigateToLogin: Bool = false
    @State private var navigateToHome: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Image("logo")
                    .resizable()
                    .frame(width: 200, height: 150)
                Spacer()
                
                NavigationLink(destination: ContentView_(), isActive: $navigateToHome) {
                    EmptyView()
                }
//                NavigationLink(destination: AthleteApp(), isActive: $navigateToHome) {
//                    EmptyView()
//                }
            }
            .navigationTitle("Welcome")
            .navigationBarHidden(true)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    navigateToHome = true
                }
            }
        }
    }
}

struct LogoScreen_Previews: PreviewProvider {
    static var previews: some View {
        LogoScreen()
    }
}
