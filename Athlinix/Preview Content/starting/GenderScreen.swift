import SwiftUI

struct GenderScreen: View {
    @State private var selectedGender: String = ""
    @Binding var selectedButton: String // Add the binding for selectedButton

    var body: some View {
        VStack {
            Text("Select your gender")
                .font(.title)
                .padding()

            Picker("Gender", selection: $selectedGender) {
                Text("Male").tag("Male")
                Text("Female").tag("Female")
                Text("Other").tag("Other")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            NavigationLink(destination: ProfilePhotoScreen(selectedButton: $selectedButton)) { // Pass selectedButton binding
                Text("Next")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 253 / 255, green: 100 / 255, blue: 48 / 255)) // Use the custom color
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            Spacer()
        }
        .navigationTitle("Gender")
    }
    private func saveGender() {
        UserManager.shared.updateCurrentUserData(key: "gender", value: selectedGender)
        selectedButton = "ProfilePhotoScreen"
    }

}

#Preview {
    @State var dummyButton = "home"
    GenderScreen(selectedButton: $dummyButton) // Simulate binding for preview
}
