import SwiftUI

struct SocialMediaFeedView1: View {
    @State private var favoritePosts: Set<UUID> = []
    @State private var userComments: [UUID: String] = [:]
    @State private var newComment: String = ""

    let feedPosts: [FeedPost1] = [
        FeedPost1(author: Account1(name: "Parth", avatarImage: "person.circle.fill"), photos: ["feed"], totalLikes: 64, message: "Last Day at SRMIST Court", logo: "pistons"),
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                ForEach(feedPosts) { feedPost in
                    FeedPostView1(feedPost: feedPost, favoritePosts: $favoritePosts, userComments: $userComments, newComment: $newComment)
                }
            }
            .padding(.horizontal)
            .background(Color(UIColor.systemGray6))
        }
    }
}


struct FeedPostView1: View {
    let feedPost: FeedPost1
    @Binding var favoritePosts: Set<UUID>
    @Binding var userComments: [UUID: String]
    @Binding var newComment: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            AccountProfileView1(account: feedPost.author)
            FeedPostImagesView1(photos: feedPost.photos)
            InteractionSection1(feedPost: feedPost, favoritePosts: $favoritePosts)
            MessageView1(feedPost: feedPost)
            CommentsSection1(feedPost: feedPost, userComments: $userComments, newComment: $newComment)
        }
        .padding(.vertical)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}


struct AccountProfileView1: View {
    let account: Account1

    var body: some View {
        HStack {
            Image(systemName: account.avatarImage)
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .padding(.trailing, 10)
            Text(account.name)
                .font(.headline)
                .foregroundColor(.primary)
            Spacer()
            Image(systemName: "ellipsis")
                .padding(.trailing, 10)
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
    }
}


struct FeedPostImagesView1: View {
    let photos: [String]

    var body: some View {
        if photos.count == 1 {
            Image(photos[0])
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        } else {
            TabView {
                ForEach(photos, id: \.self) { imageName in
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                }
            }
            .frame(height: 300)
            .tabViewStyle(PageTabViewStyle())
        }
    }
}


struct InteractionSection1: View {
    let feedPost: FeedPost1
    @Binding var favoritePosts: Set<UUID>

    var body: some View {
        HStack(spacing: 25) {
            Button(action: {
                toggleFavorite(for: feedPost.id)
            }) {
                Image(systemName: favoritePosts.contains(feedPost.id) ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(favoritePosts.contains(feedPost.id) ? .red : .gray)
            }
            Button(action: {
                // Add share action here
            }) {
                Image(systemName: "square.and.arrow.up")
                    .resizable()
                    .frame(width: 20, height: 26)
                    .foregroundColor(.green)
            }
            Spacer()
            Image(feedPost.logo)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
        }
        .padding(.horizontal)
    }

    private func toggleFavorite(for postId: UUID) {
        if favoritePosts.contains(postId) {
            favoritePosts.remove(postId)
        } else {
            favoritePosts.insert(postId)
        }
    }
}


struct MessageView1: View {
    let feedPost: FeedPost1

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("\(feedPost.totalLikes) likes")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
                .padding(.leading, 10)
            Text(feedPost.author.name)
                .font(.headline) +
            Text(" \(feedPost.message)")
                .font(.subheadline)
                .foregroundColor(.primary)
        }
        .padding(.horizontal)
    }
}


struct CommentsSection1: View {
    let feedPost: FeedPost1
    @Binding var userComments: [UUID: String]
    @Binding var newComment: String

    var body: some View {
        VStack {
            if let comment = userComments[feedPost.id], !comment.isEmpty {
                Text("Comment: \(comment)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
            }
            HStack {
                TextField("Write a comment...", text: $newComment)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                Button("Send") {
                    if !newComment.isEmpty {
                        userComments[feedPost.id] = newComment
                        newComment = ""
                    }
                }
                .padding(.trailing)
            }
        }
    }
}


struct Account1 {
    let name: String
    let avatarImage: String
}

struct FeedPost1: Identifiable {
    let id = UUID()
    let author: Account1
    let photos: [String]
    let totalLikes: Int
    let message: String
    let logo: String
}


struct SocialMediaFeedView1_Previews: PreviewProvider {
    static var previews: some View {
        SocialMediaFeedView1()
            .padding()
            .previewLayout(.sizeThatFits)
            .background(Color(.systemGray6))
    }
}
