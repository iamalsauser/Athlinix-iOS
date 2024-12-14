import SwiftUI

struct PhoneNumberScreen: View {
    @State private var phoneNumber: String = ""
    @State private var selectedCountry: String = "US" // Default country code
    @Binding var selectedButton: String // Add the binding for selectedButton
    private let countryCodes = ["US", "CA", "IN", "GB", "AU"] // Add more country codes as needed

    var body: some View {
        VStack(alignment: .leading) { // Align content to the leading edge (left)
            VStack(alignment: .leading) {
                Image("call") // Replace with your actual logo asset name
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 50) // Adjust the size as needed
                    .padding(.top, 40) // Padding at the top
                
                Text("What's your phone number?")
                    .font(.title)
                    .padding(.top, 10) // Padding between logo and title
            }

            HStack {
                // Country selection
                Picker("Select Country", selection: $selectedCountry) {
                    ForEach(countryCodes, id: \.self) { country in
                        Text(country).tag(country)
                    }
                }
                .pickerStyle(MenuPickerStyle()) // Use a menu style for a dropdown
                .frame(width: 100) // Adjust width as needed
                
                // Phone number entry
                TextField("Phone Number", text: $phoneNumber)
                    .keyboardType(.phonePad)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5)
                    .padding(.leading, 8) // Spacing between the picker and text field
            }
            .padding(.bottom, 20) // Padding below the HStack

            NavigationLink(destination: BirthDateScreen(selectedButton: $selectedButton)) { // Pass the binding to BirthDateScreen
                Text("Next")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 253/255, green: 100/255, blue: 48/255))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle("Phone Number")
        .padding(.leading) // Add some padding on the leading edge
        .padding(.bottom, 20) // Additional bottom padding for overall spacing
    }
    private func savePhoneNumber() {
        let fullPhoneNumber = "\(selectedCountry) \(phoneNumber)"
        UserManager.shared.updateCurrentUserData(key: "phoneNumber", value: fullPhoneNumber)
        selectedButton = "BirthDateScreen" // Navigate to next screen
    }
}



struct Phone_Previews: PreviewProvider {
    @State static var dummyButton = "home"
    
    static var previews: some View {
        PhoneNumberScreen(selectedButton: $dummyButton) // Simulate binding for preview
    }
}
