import SwiftUI

struct LoginScreen: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    @Binding var selectedButton: String // To navigate after login or signup

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
                    .background(Color.blue)
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
        if UserManager.shared.authenticateUser(email: email, password: password) {
            if UserManager.shared.getUser(byEmail: email) != nil {
                        selectedButton = "PhoneNumberScreen" // Navigate to PhoneNumberScreen
            } else {
                selectedButton = "home" // Navigate to Home screen
            }
        } else {
            errorMessage = "Invalid email or password. Please try again."
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    @State static var dummyButton: String = "login"

    static var previews: some View {
        LoginScreen(selectedButton: $dummyButton)
    }
}
