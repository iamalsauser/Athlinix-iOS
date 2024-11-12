import SwiftUI

struct cProfileView: View {
    var body: some View {
        NavigationView {
            ZStack {
                
                Image("coach")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: 250)
                    .blur(radius: 0)
                    .clipped()
                    .edgesIgnoringSafeArea(.all)
                    .shadow(radius: 50)
                    .padding(.bottom, 60)
                
                VStack {
                    
                    Image("cavs")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .padding(.top, 50)
                        .shadow(radius: 10)
                    
                    
                }
                .padding(.top, 120)
            }
            .overlay(
                NavigationLink(destination: DestinationView()) {
                    Image("lakers")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding()
                }
                .buttonStyle(PlainButtonStyle()),
                alignment: .topTrailing
            )
        }
    }
}


struct DestinationView: View {
    var body: some View {
        Image("licence")
            .font(.largeTitle)
            .padding()
    }
}

struct cProfileView_Previews: PreviewProvider {
    static var previews: some View {
        cProfileView()
    }
}
