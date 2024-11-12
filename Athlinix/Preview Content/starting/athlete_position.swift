import SwiftUI

struct Athlete_position: View {
    @State private var selectedSkillLevel: String = ""
    @Binding var selectedButton: String // Declare a binding for selectedButton
    let skillLevels = ["Point Guard (PG)", "Shooting Guard (SG)", "Small Forward (SF)","Power Forward (PF)","Center (C)"]

    var body: some View {
        VStack {
            Text("What is your Position?")
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

            NavigationLink(destination: SkillLevelScreen(selectedButton: $selectedButton)) { // Pass the binding here
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

struct Position_previews: PreviewProvider {
    static var previews: some View {
        // Create a preview with a dummy binding
        @State var dummyButton: String = "home"
        return Athlete_position(selectedButton: $dummyButton) // Pass a binding for preview
    }
}
