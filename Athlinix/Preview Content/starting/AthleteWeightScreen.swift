import SwiftUI

struct AthleteWeightScreen: View {
    @State private var weight: Double = 70 // Default weight value
    let weights: [Double] = Array(30...200).map { Double($0) } // Range of weights from 30 to 200 kg
    @Binding var selectedButton: String // Declare a binding for selectedButton

    var body: some View {
        VStack {
            Text("Enter your weight (kg)")
                .font(.title)
                .padding()

            // Customized Picker for weight with wheel style
            Picker("Weight", selection: $weight) {
                ForEach(weights, id: \.self) { weight in
                    Text("\(Int(weight)) kg").tag(weight)
                }
            }
            .pickerStyle(WheelPickerStyle()) // Use wheel style for a scrolling effect
            .frame(maxHeight: 200) // Adjust the height to suit the wheel display
            .padding()

            NavigationLink(destination: Athlete_position(selectedButton: $selectedButton)) {
                Text("Next")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 253/255, green: 100/255, blue: 48/255))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .onTapGesture {
                        UserManager.shared.updateCurrentUserData(key: "weight", value: weight)
                    }
            }

            .padding()

            Spacer()
        }
        .navigationTitle("Weight")
        .padding(.horizontal) // Add horizontal padding to the entire screen
    }
}

struct Weight_Previews: PreviewProvider {
    static var previews: some View {
        // Create a preview with a dummy binding
        @State var dummyButton: String = "home"
        return AthleteWeightScreen(selectedButton: $dummyButton) // Pass a binding for preview
    }
}
