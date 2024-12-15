import SwiftUI

// MARK: - Main App

struct AthleteApp: View {
    @State private var navigateToLogin = false

    var body: some View {
        VStack {
            Text("Welcome to Athlete App")
                .font(.largeTitle)
                .padding()

            Button("Login") {
                navigateToLogin = true
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationDestination(isPresented: $navigateToLogin) {
            AthleteLoginView() // Navigate to login view
        }
    }
}


// MARK: - Login Screen
struct AthleteLoginView: View {
    @State private var userEmail = ""
    @State private var userPassword = ""
    @State private var showSignup = false
    @State private var proceedToNext = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Login").font(.largeTitle).bold()

            TextField("Email", text: $userEmail)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .padding()

            SecureField("Password", text: $userPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Login") {
                UserDefaults.standard.set(userEmail, forKey: "athleteUserEmail")
                proceedToNext = true
            }
            .buttonStyle(.borderedProminent)

            Button("Signup") {
                showSignup = true
            }
        }
        .padding()
        .navigationDestination(isPresented: $proceedToNext) {
            AthleteRoleSelectionView()
        }
        .sheet(isPresented: $showSignup) {
            AthleteSignupView()
        }
    }
}

// MARK: - Signup Screen
struct AthleteSignupView: View {
    @State private var newUsername = ""
    @State private var newPassword = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Signup").font(.largeTitle).bold()

            TextField("Username", text: $newUsername)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $newPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Create Account") {
                UserDefaults.standard.set(newUsername, forKey: "athleteNewUsername")
                UserDefaults.standard.set(newPassword, forKey: "athleteNewPassword")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

// MARK: - Role Selection Screen
struct AthleteRoleSelectionView: View {
    @State private var selectedRole = "Player"
    let roleOptions = ["Player", "Coach", "Manager"]

    var body: some View {
        VStack {
            Text("Select Role")
                .font(.headline)

            Picker("Role", selection: $selectedRole) {
                ForEach(roleOptions, id: \.self) { role in
                    Text(role).tag(role)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            Button("Next") {
                UserDefaults.standard.set(selectedRole, forKey: "athleteRole")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

// MARK: - Gender Screen
struct AthleteGenderView: View {
    @State private var genderSelection = "Male"
    let genderOptions = ["Male", "Female", "Other"]

    var body: some View {
        VStack {
            Text("Select Gender")
                .font(.headline)

            Picker("Gender", selection: $genderSelection) {
                ForEach(genderOptions, id: \.self) { gender in
                    Text(gender).tag(gender)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            Button("Next") {
                UserDefaults.standard.set(genderSelection, forKey: "athleteGender")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

// MARK: - Birth Date Screen
struct AthleteBirthDateView: View {
    @State private var selectedBirthDate = Date()

    var body: some View {
        VStack {
            Text("Select Birth Date")
                .font(.headline)

            DatePicker("Birth Date", selection: $selectedBirthDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()

            Button("Next") {
                UserDefaults.standard.set(selectedBirthDate, forKey: "athleteBirthDate")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

// MARK: - Athlete Position Screen
struct AthletePositionView: View {
    @State private var athletePosition = "Point Guard (PG)"
    let positionOptions = ["Point Guard (PG)", "Shooting Guard (SG)", "Small Forward (SF)", "Power Forward (PF)", "Center (C)"]

    var body: some View {
        VStack {
            Text("Select Athlete Position")
                .font(.headline)

            Picker("Athlete Position", selection: $athletePosition) {
                ForEach(positionOptions, id: \.self) { position in
                    Text(position).tag(position)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .padding()

            Button("Next") {
                UserDefaults.standard.set(athletePosition, forKey: "athletePosition")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

// MARK: - Athlete Height Screen
struct AthleteHeightView: View {
    @State private var athleteHeight = ""

    var body: some View {
        VStack {
            Text("Enter Athlete Height (in cm)")
                .font(.headline)

            TextField("Height in cm", text: $athleteHeight)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Next") {
                UserDefaults.standard.set(athleteHeight, forKey: "athleteHeight")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

// MARK: - Athlete Weight Screen
struct AthleteWeightView: View {
    @State private var athleteWeight = ""

    var body: some View {
        VStack {
            Text("Enter Athlete Weight (in kg)")
                .font(.headline)

            TextField("Weight in kg", text: $athleteWeight)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Next") {
                UserDefaults.standard.set(athleteWeight, forKey: "athleteWeight")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

// MARK: - Skill Level Screen
struct AthleteSkillLevelView: View {
    @State private var skillLevel = "Beginner"
    let skillLevelOptions = ["Beginner", "Intermediate", "Advanced"]

    var body: some View {
        VStack {
            Text("Select Skill Level")
                .font(.headline)

            Picker("Skill Level", selection: $skillLevel) {
                ForEach(skillLevelOptions, id: \.self) { level in
                    Text(level).tag(level)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            Button("Next") {
                UserDefaults.standard.set(skillLevel, forKey: "athleteSkillLevel")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

// MARK: - How Long Playing Screen
struct AthletePlayingExperienceView: View {
    @State private var playingYears = ""

    var body: some View {
        VStack {
            Text("How Many Years Have You Been Playing?")
                .font(.headline)

            TextField("Years Playing", text: $playingYears)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Next") {
                UserDefaults.standard.set(playingYears, forKey: "athletePlayingYears")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

// MARK: - Profile Photo Screen
struct AthleteProfilePhotoView: View {
    @State private var showImagePicker = false
    @State private var profileImage: UIImage?

    var body: some View {
        VStack {
            Text("Upload Profile Photo")
                .font(.headline)

            if let image = profileImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            } else {
                Button("Choose Photo") {
                    showImagePicker = true
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .sheet(isPresented: $showImagePicker) {
            AthleteImagePicker(selectedImage: $profileImage)
        }
        .padding()
    }
}

// MARK: - Location Screen
struct AthleteLocationView: View {
    @State private var userLocation = ""

    var body: some View {
        VStack {
            Text("Enter Your Location")
                .font(.headline)

            TextField("City, Country", text: $userLocation)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Next") {
                UserDefaults.standard.set(userLocation, forKey: "athleteLocation")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

// MARK: - Image Picker Helper
struct AthleteImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: AthleteImagePicker

        init(_ parent: AthleteImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            picker.dismiss(animated: true)
        }
    }
}
