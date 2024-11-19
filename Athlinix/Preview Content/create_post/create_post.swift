import SwiftUI
import PhotosUI
import Foundation

struct CreatePostView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedImages: [UIImage] = []
    @State private var isImagePickerPresented = false
    @State private var team1Score: Int = 0
    @State private var team2Score: Int = 0
    @State private var selectedImageItem: PhotosPickerItem?
    @State private var destination: String = ""
    @State private var selectedTeamMembers: [String] = [] // Changed to team members as strings
    @State private var post: Postview?
    
    let maxImages = 5
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(selectedImages.indices, id: \.self) { index in
                                Image(uiImage: selectedImages[index])
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 300, height: 300)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                            
                            if selectedImages.count < maxImages {
                                PhotosPicker(selection: $selectedImageItem,
                                           matching: .images) {
                                    AddImageButton()
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Destination Text Input
                    VStack {
                        Text("Destination")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                        
                        TextField("Enter Destination", text: $destination)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .padding(.horizontal)
                    }
                    
                    HStack(spacing: 40) {
                        TeamScoreView(
                            teamLogo: "lakersLogo",
                            teamName: "South Cali",
                            subTitle: "Your Team",
                            score: $team1Score
                        )
                        
                        Text("VS")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        TeamScoreView(
                            teamLogo: "plus",
                            teamName: "Add",
                            subTitle: "Opponent",
                            score: $team2Score
                        )
                    }
                    .padding()

                    // Team section
                    VStack {
                        Text("Team")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)

                        NavigationLink(destination: InviteTeamView(selectedTeamMembers: $selectedTeamMembers)) {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.orange)
                                .clipShape(Circle())
                        }
                    }
                    .padding(.top, 10)

                    // Create Post Button
                    Button(action: {
                        createPost()
                    }) {
                        Text("Create Post")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    .padding(.top, 20)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Create Post")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        .onChange(of: selectedImageItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {
                    selectedImages.append(image)
                    print("Image added: \(image)") // Debug print
                }
            }
        }
    }
    
    private func createPost() {
        let post = Postview(
            destination: destination,
            team1Score: team1Score,
            team2Score: team2Score,
            images: selectedImages,  // Convert UIImage to Data
            teamMembers: selectedTeamMembers
        )
        
        print("Post created: \(post)")  // Debug print
        savePostToJson(post: post)
    }

    private func savePostToJson(post: Postview) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(post)
            let filename = getDocumentsDirectory().appendingPathComponent("post.json")
            try data.write(to: filename)
            print("Post saved to \(filename)")  // Debug print
        } catch {
            print("Error saving post: \(error)")  // Debug print
        }
    }

    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

struct Postview: Codable {
    var destination: String
    var team1Score: Int
    var team2Score: Int
    var images: [Data]  // Change UIImage to Data
    var teamMembers: [String]
    
    enum CodingKeys: String, CodingKey {
        case destination
        case team1Score
        case team2Score
        case images
        case teamMembers
    }
    
    init(destination: String, team1Score: Int, team2Score: Int, images: [UIImage], teamMembers: [String]) {
        self.destination = destination
        self.team1Score = team1Score
        self.team2Score = team2Score
        self.images = images.compactMap { $0.pngData() }  // Convert UIImage to Data
        self.teamMembers = teamMembers
    }
    
    // Decode images from Data to UIImage
    func decodedImages() -> [UIImage] {
        return images.compactMap { UIImage(data: $0) ?? UIImage() }
    }
}

struct AddImageButton: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .stroke(Color.gray.opacity(0.3), style: StrokeStyle(lineWidth: 1, dash: [5]))
            .frame(width: 300, height: 300)
            .overlay(
                Image(systemName: "plus")
                    .font(.system(size: 40))
                    .foregroundColor(.gray)
            )
    }
}

struct TeamScoreView: View {
    let teamLogo: String
    let teamName: String
    let subTitle: String
    @Binding var score: Int
    
    var body: some View {
        VStack(spacing: 12) {
            Image(teamLogo)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            
            Text(teamName)
                .font(.subheadline)
                .fontWeight(.medium)
            
            Text(subTitle)
                .font(.caption)
                .foregroundColor(.gray)
            
            HStack {
                Button(action: { if score > 0 { score -= 1 } }) {
                    Image(systemName: "minus.circle")
                        .font(.title2)
                }
                
                Text("\(score)")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .frame(minWidth: 40)
                
                Button(action: { score += 1 }) {
                    Image(systemName: "plus.circle")
                        .font(.title2)
                }
            }
        }
    }
}

struct InviteTeamView: View {
    @Binding var selectedTeamMembers: [String]
    
    var body: some View {
        VStack {
            ForEach(selectedTeamMembers, id: \.self) { member in
                Text(member)
                    .padding()
            }
            
            Button(action: {
                selectedTeamMembers.append("New Member")
            }) {
                Text("Add Team Member")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
        }
        .navigationBarTitle("Select Team Members", displayMode: .inline)
    }
}

struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView()
    }
}
