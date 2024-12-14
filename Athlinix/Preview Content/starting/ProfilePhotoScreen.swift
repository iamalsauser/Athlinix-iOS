import SwiftUI

struct ProfilePhotoScreen: View {
    @State private var showImagePicker: Bool = false
    @State private var selectedImage: UIImage?
    @Binding var selectedButton: String // Add a binding for selectedButton

    var body: some View {
        VStack {
            Text("Pick your profile photo")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 40) // Padding at the top

            // Display selected image or a placeholder
            Button(action: {
                showImagePicker = true
            }) {
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle()) // Circular shape for the profile photo
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1)) // Border around the photo
                        .padding()
                } else {
                    // Placeholder for the profile image
                    Circle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 120, height: 120)
                        .overlay(Text("Add Photo").foregroundColor(.gray)) // Placeholder text
                        .padding()
                }
            }
            .buttonStyle(PlainButtonStyle()) // Prevent button style interference

            NavigationLink(destination: RoleSelectionScreen(selectedButton: $selectedButton)) {
                Text("Next")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 253/255, green: 100/255, blue: 48/255))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            Spacer()
        }
        .navigationTitle("Profile Photo")
        .padding(.horizontal) // Add horizontal padding to the entire screen
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $selectedImage) // Assuming ImagePicker is your custom image picker
        }
    }
    private func saveImage() {
        if let image = selectedImage, let imageData = image.jpegData(compressionQuality: 0.8) {
            UserManager.shared.updateCurrentUserData(key: "profilePhoto", value: imageData)
        }
        selectedButton = "RoleSelectionScreen"
    }

}

struct ProfilePhoto_Previews: PreviewProvider {
    static var previews: some View {
        @State var dummyButton: String = "home"
        ProfilePhotoScreen(selectedButton: $dummyButton) // Preview with binding
    }
}
