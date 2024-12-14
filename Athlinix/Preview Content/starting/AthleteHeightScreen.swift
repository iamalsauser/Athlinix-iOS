import SwiftUI

struct AthleteHeightScreen: View {
    @State private var height: Double = 170 // Default height value
    let heights: [Double] = Array(100...250).map { Double($0) } // Range of heights from 100 to 250 cm
    @Binding var selectedButton: String // Declare a binding for selectedButton

    var body: some View {
        VStack {
            Text("Enter your height (cm)")
                .font(.title)
                .padding()

            // Customized Picker for height with wheel style
            Picker("Height", selection: $height) {
                ForEach(heights, id: \.self) { height in
                    Text("\(Int(height)) cm").tag(height)
                }
            }
            .pickerStyle(WheelPickerStyle()) // Use wheel style for a scrolling effect
            .frame(maxHeight: 200) // Adjust the height to suit the wheel display
            .padding()

            NavigationLink(destination: AthleteWeightScreen(selectedButton: $selectedButton)) {
                Text("Next")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 253/255, green: 100/255, blue: 48/255))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .onTapGesture {
                        UserManager.shared.updateCurrentUserData(key: "height", value: height)
                    }
            }

            .padding()

            Spacer()
        }
        .navigationTitle("Height")
        .padding(.horizontal) // Add horizontal padding to the entire screen
    }
}

struct Height_Previews: PreviewProvider {
    static var previews: some View {
        // Create a preview with a dummy binding
        @State var dummyButton: String = "home"
        return AthleteHeightScreen(selectedButton: $dummyButton) // Pass a binding for preview
    }
}
