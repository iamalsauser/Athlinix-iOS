import SwiftUI

// Model for Profile
struct UserProfile: Identifiable {
    let id = UUID()
    let name: String
    let profileImage: String
    var isFollowed: Bool = false
}

struct ProfileSliderView: View {
    @State private var profiles: [UserProfile] = [
        UserProfile(name: "Athlete1", profileImage: "profile1"),
        UserProfile(name: "Athlete2", profileImage: "profile2"),
        UserProfile(name: "Athlete3", profileImage: "profile3"),
        UserProfile(name: "Athlete4", profileImage: "profile4"),
        UserProfile(name: "Athlete5", profileImage: "profile5")
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("More Profiles")
                .font(.headline)
                .padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(profiles.indices, id: \.self) { index in
                        ProfileCardView(profile: $profiles[index])
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.top)
    }
}


struct ProfileCardView: View {
    @Binding var profile: UserProfile
    
    var body: some View {
        NavigationLink(destination: ProfileStat(selectedButton: .constant("profile"))) {
            VStack(spacing: 8) {
                Image(profile.profileImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 3)
                
                Text(profile.name)
                    .font(.subheadline)
                    .lineLimit(1)
                
                Button(action: {
                    profile.isFollowed.toggle()
                }) {
                    Text(profile.isFollowed ? "Following" : "Follow")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 16)
                        .background(profile.isFollowed ? Color.green : Color(red: 253/255, green: 100/255, blue: 48/255)) // FD6430 color
                        .cornerRadius(15)
                }
            }
            .frame(width: 80)
        }
    }
}

struct ProfileSliderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileSliderView()
        }
    }
}
