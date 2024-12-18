import SwiftUI

struct LoginScreen: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    @Binding var selectedButton: String // Binding for navigation to different views

    var body: some View {
        VStack {
            Text("Athlinix Login")
                .font(.largeTitle)
                .padding()

            TextField("Enter your email", text: $email)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5)
                .padding(.horizontal)

            SecureField("Enter your password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5)
                .padding(.horizontal)

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.subheadline)
                    .padding(.bottom, 10)
                    .padding(.horizontal)
            }

            Button(action: login) {
                Text("Login")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "fd6430"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }

            Spacer()

            Text("Don't have an account? Sign up")
                .font(.subheadline)
                .foregroundColor(.blue)
                .onTapGesture {
                    selectedButton = "createAccount" // Navigate directly to CreateAccountScreen
                }
                .padding(.top, 20)

            Spacer()
        }
    }

    private func login() {
        if let user = UserManager.shared.getCompleteUser(byEmail: email) {
            if user.basicInfo.password == password {
                selectedButton = "home" // Navigate directly to HomeScreen
            } else {
                errorMessage = "Invalid password. Please try again."
            }
        } else {
            errorMessage = "User not found. Please check your email."
        }
    }

}

struct LoginScreen_Previews: PreviewProvider {
    @State static var dummyButton: String = "login"

    static var previews: some View {
        LoginScreen(selectedButton: $dummyButton)
    }
}

extension Color {
    /// Helper initializer to use hex color codes.
    init(hex0: String) {
        let scanner = Scanner(string: hex0)
        _ = scanner.scanString("#") // Ignore the `#` if present
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}
