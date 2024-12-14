import SwiftUI

struct RoleSelectionScreen: View {
    @State private var selectedRole: String = ""
    @Binding var selectedButton: String // Declare a binding for selectedButton

    var body: some View {
        VStack(alignment: .leading) { // Align content to the leading edge (left)
            VStack(alignment: .leading) {
                Image("role") // Replace with your actual logo asset name
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50) // Adjust the size as needed
                    .padding(.all, 20) // Padding around the logo
                
                Text("Are you a coach or athlete?")
                    .font(.title)
                    .padding(.all, 10) // Padding between logo and title
            }

            // Role Picker
            Picker("Role", selection: $selectedRole) {
                Text("Coach").tag("Coach")
                Text("Athlete").tag("Athlete")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            // Navigation based on role
            if selectedRole == "Coach" {
                NavigationLink(destination: coachexp(selectedButton: $selectedButton)) {
                    Text("Next")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 253/255, green: 100/255, blue: 48/255))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                .onTapGesture {
                    saveRole(role: "Coach")
                }
            } else if selectedRole == "Athlete" {
                NavigationLink(destination: AthleteHeightScreen(selectedButton: $selectedButton)) {
                    Text("Next")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 253/255, green: 100/255, blue: 48/255))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                .onTapGesture {
                    saveRole(role: "Athlete")
                }
            }

            Spacer()
        }
        .navigationTitle("Role Selection")
        .padding(.horizontal) // Add horizontal padding to the entire screen
    }
    
    /// Save the selected role to UserManager
    private func saveRole(role: String) {
        UserManager.shared.updateCurrentUserData(key: "role", value: role)
    }
}

struct RoleSelection_Previews: PreviewProvider {
    static var previews: some View {
        // Create a preview with a dummy binding
        @State var dummyButton: String = "home"
        return RoleSelectionScreen(selectedButton: $dummyButton) // Pass a binding for preview
    }
}
