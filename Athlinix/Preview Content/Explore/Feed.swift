import SwiftUI

struct InstagramFeedView: View {
    @State private var likedPosts: Set<UUID> = []
    @State private var comments: [UUID: String] = [:]
    @State private var commentInput: String = ""

    let posts: [Post] = [
        Post(user: User(name: "Lebron James", profileImage: "person.circle.fill"), images: ["feed1", "feed3"], likes: 120, caption: "Just scored the game-winning shot!", teamLogo: "lakers"),
        Post(user: User(name: "Roshan Singh", profileImage: "person.circle.fill"), images: ["feed2", "feed4", "feed5"], likes: 85, caption: "Had an amazing game under the sun!", teamLogo: "spurs1"),
        Post(user: User(name: "Dev Karan Singh", profileImage: "person.circle.fill"), images: ["feed7", "feed6"], likes: 200, caption: "Exploring new plays with my teammates.", teamLogo: "pistons"),
        Post(user: User(name: "Nand Merja", profileImage: "person.circle.fill"), images: ["profile3"], likes: 64, caption: "Enjoying a victory celebration!", teamLogo: "warriors"),
        Post(user: User(name: "Parth Sinh", profileImage: "person.circle.fill"), images: ["feed3"], likes: 64, caption: "Practicing my free throws at the court.", teamLogo: "toronto"),
    ]

    var body: some View {
        NavigationView { // Wrap in NavigationView
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(posts) { post in
                        PostView(post: post, likedPosts: $likedPosts, comments: $comments, commentInput: $commentInput)
                    }
                }
                .padding(.horizontal)
                .background(Color(UIColor.systemGray6))
            }
        }
    }
}

struct PostView: View {
    let post: Post
    @Binding var likedPosts: Set<UUID>
    @Binding var comments: [UUID: String]
    @Binding var commentInput: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            NavigationLink(destination: ProfileStat1(selectedButton: .constant("profile"))) {
                UserProfileView(user: post.user)
            }
            PostImagesView(images: post.images)
            LikeShareSection(post: post, likedPosts: $likedPosts)
            CaptionView(post: post)
            CommentSection(post: post, comments: $comments, commentInput: $commentInput)
        }
        .padding(.vertical)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}


struct UserProfileView: View {
    let user: User

    var body: some View {
        HStack {
            Image(systemName: user.profileImage)
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .padding(.trailing, 10)
            Text(user.name)
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


struct PostImagesView: View {
    let images: [String]

    var body: some View {
        if images.count == 1 {
            Image(images[0])
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        } else {
            TabView {
                ForEach(images, id: \.self) { imageName in
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


struct LikeShareSection: View {
    let post: Post
    @Binding var likedPosts: Set<UUID>

    var body: some View {
        HStack(spacing: 25) {
            Button(action: {
                toggleLike(for: post.id)
            }) {
                Image(systemName: likedPosts.contains(post.id) ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(likedPosts.contains(post.id) ? .red : .gray)
            }
            Button(action: {}) {
                Image(systemName: "square.and.arrow.up")
                    .resizable()
                    .frame(width: 20, height: 26)
                    .foregroundColor(.green)
            }
            Spacer()
            Image(post.teamLogo)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
        }
        .padding(.horizontal)
    }

    private func toggleLike(for postId: UUID) {
        if likedPosts.contains(postId) {
            likedPosts.remove(postId)
        } else {
            likedPosts.insert(postId)
        }
    }
}


struct CaptionView: View {
    let post: Post

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("\(post.likes) likes")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
                .padding(.leading, 10)
            Text(post.user.name)
                .font(.headline) +
            Text(" \(post.caption)")
                .font(.subheadline)
                .foregroundColor(.primary)
        }
        .padding(.horizontal)
    }
}


struct CommentSection: View {
    let post: Post
    @Binding var comments: [UUID: String]
    @Binding var commentInput: String

    var body: some View {
        VStack {
            if let comment = comments[post.id], !comment.isEmpty {
                Text("Comment: \(comment)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
            }
            HStack {
                TextField("Add a comment...", text: $commentInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                Button("Post") {
                    if !commentInput.isEmpty {
                        comments[post.id] = commentInput
                        commentInput = ""
                    }
                }
                .padding(.trailing)
            }
        }
    }
}


struct User {
    let name: String
    let profileImage: String
}

struct Post: Identifiable {
    let id = UUID()
    let user: User
    let images: [String]
    let likes: Int
    let caption: String
    let teamLogo: String
}


struct InstagramFeedView_Previews: PreviewProvider {
    static var previews: some View {
        InstagramFeedView()
    }
}
