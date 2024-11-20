import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack {
            // Blurred background using the same profile image
            Image("profile1") // Replace with your actual profile image
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: 250)
                .blur(radius: 20)
                .clipped()
                .edgesIgnoringSafeArea(.all).shadow(radius: 50).padding(.bottom,60)
            
            VStack {
                
                
                // Circle profile image in the middle
                Image("profile1") // Replace with your actual profile image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle()).padding(.top,50)
//                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                
                // Best Game at the bottom
            }
            .padding(.top, 120) // Adjust the spacing if necessary
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
