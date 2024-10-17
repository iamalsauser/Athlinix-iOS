import SwiftUI

struct SkillLevelScreen: View {
    @State private var selectedSkillLevel: String = ""
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

            NavigationLink(destination: YearsPlayingScreen()) {
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
        .navigationTitle("Skill Level")
        .padding(.horizontal) // Add horizontal padding to the entire screen
    }
}

struct Skill_Previews: PreviewProvider {
    static var previews: some View {
        SkillLevelScreen() // Preview the SkillLevelScreen
    }
}