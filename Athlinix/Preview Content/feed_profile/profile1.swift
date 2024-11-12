import SwiftUI

struct ProfileView1: View {
    var body: some View {
        ZStack {
            
            Image("profile") 
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: 250)
                .blur(radius: 20)
                .clipped()
                .edgesIgnoringSafeArea(.all).shadow(radius: 50).padding(.bottom,60)
            
            VStack {
                
                
                
                Image("profile")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle()).padding(.top,50)

                    .shadow(radius: 10)
                
                
            }
            .padding(.top, 120) 
        }
    }
}

struct ProfileView_Previews1: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
