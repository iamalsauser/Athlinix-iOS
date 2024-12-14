import SwiftUI

struct BirthDateScreen: View {
    @State private var birthDate: Date = Date()
    @Binding var selectedButton: String // Add the binding for selectedButton

    var body: some View {
        VStack {
            Text("Enter your birth date")
                .font(.title)
                .padding()

            // Customized DatePicker with wheel style
            DatePicker("Birth Date", selection: $birthDate, displayedComponents: .date)
                .datePickerStyle(.wheel) // Use the wheel style for a scrolling effect
                .labelsHidden() // Hide the label "Birth Date" for cleaner UI
                .padding()
                .frame(maxHeight: 200) // Adjust the height to suit the wheel display

            NavigationLink(destination: GenderScreen(selectedButton: $selectedButton)) { // Pass the binding to LocationScreen
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
        .navigationTitle("Birth Date")
    }
}

#Preview {
    @State var dummyButton = "home"
    BirthDateScreen(selectedButton: $dummyButton) // Simulate binding for preview
}
