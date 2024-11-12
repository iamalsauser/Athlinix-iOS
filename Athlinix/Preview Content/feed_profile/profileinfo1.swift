import SwiftUI

struct ProfileInfoView1: View {
    var body: some View {
        VStack {
            
            HStack(spacing: 5) {
                Text("Lebron James")
                    .font(.title)
                    .bold()
                    .padding(.leading)

                
                Image(systemName: "checkmark.seal.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(red: 253 / 255, green: 100 / 255, blue: 48 / 255))
            }
            

            
            Text("Player - 10yrs exp.")
                .foregroundColor(.gray)
            
            
            Text("Basketball player with a passion for the game, always hustling and chasing... More")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
        }
    }
}

struct ProfileInfoView_Previews1: PreviewProvider {
    static var previews: some View {
        ProfileInfoView()
    }
}

