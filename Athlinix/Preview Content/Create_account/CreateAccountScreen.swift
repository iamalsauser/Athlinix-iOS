import SwiftUI

struct CreateAccountScreen: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @Binding var selectedButton: String
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            Text("Athlinix")
                .font(.largeTitle)
                .padding()

            TextField("Enter your email", text: $username)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5)
                .padding()

            SecureField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5)
                .padding()

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.subheadline)
                    .padding(.bottom, 10)
            }

            Button(action: createAccount) {
                Text("Next")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 253 / 255, green: 100 / 255, blue: 48 / 255))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            Spacer()

            Text("Already have an account? Login")
                .font(.subheadline)
                .foregroundColor(.blue)
                .onTapGesture {
                    selectedButton = "login" // Navigate back to LoginScreen
                }
                .padding(.top, 20)

            Spacer()
        }
    }

    private func createAccount() {
        // Validate inputs
        guard !username.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in all fields."
            return
        }
        guard isValidEmail(username) else {
            errorMessage = "Please enter a valid email address."
            return
        }

        // Check if the user already exists
        if UserManager.shared.getUser(byEmail: username) != nil {
            errorMessage = "This email is already registered."
            return
        }

        // Save new user
        let newUser = User_(email: username, password: password)
        UserManager.shared.saveUser(newUser)

        // Navigate to the login screen
        selectedButton = "login"
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: email)
    }
}

struct CreateAccount_Previews: PreviewProvider {
    @State static var dummyButton = "home"

    static var previews: some View {
        CreateAccountScreen(selectedButton: $dummyButton)
    }
}
