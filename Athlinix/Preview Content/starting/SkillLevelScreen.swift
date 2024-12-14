import SwiftUI

struct SkillLevelScreen: View {
    @State private var selectedSkillLevel: String = ""
    @Binding var selectedButton: String // Declare a binding for selectedButton
    let skillLevels = ["Amateur", "Semi-Professional", "Professional"]

    var body: some View {
        VStack {
            Text("What is your skill level?")
                .font(.title)
                .padding()

            // Customized Picker for skill level with wheel style
            Picker("Skill Level", selection: $selectedSkillLevel) {
                ForEach(skillLevels, id: \.self) { level in
                    Text(level).tag(level)
                }
            }
            .pickerStyle(WheelPickerStyle()) // Use wheel style for a scrolling effect
            .frame(maxHeight: 200) // Adjust the height to suit the wheel display
            .padding()

            NavigationLink(destination: YearsPlayingScreen(selectedButton: $selectedButton)) {
                Text("Next")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 253/255, green: 100/255, blue: 48/255))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .onTapGesture {
                        UserManager.shared.updateCurrentUserData(key: "skillLevel", value: selectedSkillLevel)
                    }
            }

            .padding()

            Spacer()
        }
        .navigationTitle("Skill Level")
        .padding(.horizontal) // Add horizontal padding to the entire screen
    }
}

struct Skill_Previews: PreviewProvider {
    static var previews: some View {
        // Create a preview with a dummy binding
        @State var dummyButton: String = "home"
        return SkillLevelScreen(selectedButton: $dummyButton) // Pass a binding for preview
    }
}
