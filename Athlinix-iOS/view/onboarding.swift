import SwiftUI

struct OnboardingView: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    
    
    @State private var playerPosition = ""
    @State private var height = ""
    @State private var weight = ""
    @State private var birthdate = Date()
    @State private var gender = ""
    @State private var location = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Player Information")) {
                    TextField("Player Position (e.g., Point Guard)", text: $playerPosition)
                    TextField("Height (in cm)", text: $height)
                        .keyboardType(.decimalPad)
                    TextField("Weight (in kg)", text: $weight)
                        .keyboardType(.decimalPad)
                    DatePicker("Birthdate", selection: $birthdate, displayedComponents: .date)
                    TextField("Gender", text: $gender)
                    TextField("Location (e.g., City, Country)", text: $location)
                }
            }
            .navigationTitle("Onboarding")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        Task {
                            await saveOnboardingData()
                            dismiss()
                        }
                    }
                }
            }
        }
    }
    
    private func saveOnboardingData() async {
        
        let heightValue = Double(height) ?? 0.0
        let weightValue = Double(weight) ?? 0.0
        
        
        if var currentStats = viewModel.statistics {
            currentStats.playerPosition = playerPosition
            currentStats.height = heightValue
            currentStats.weight = weightValue
            currentStats.birthdate = birthdate
            currentStats.gender = gender
            currentStats.location = location
            
            
            do {
                let updatedStats: [Statistics] = try await viewModel.supabase
                    .from(Table.statistics)
                    .update(currentStats)
                    .eq("id", value: currentStats.id!)
                    .select()
                    .execute()
                    .value
                
                if let updated = updatedStats.first {
                    DispatchQueue.main.async {
                        viewModel.statistics = updated
                    }
                }
            } catch {
                print("Error saving onboarding data: \(error)")
            }
        }
    }
}
