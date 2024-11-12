import SwiftUI

struct AllMatchesScreen: View {
    var body: some View {
        VStack {
            
            Text("Matches")
                .font(.largeTitle)
                .padding()
            
            
            AllMatchesList()
            
            Spacer()
        }
        .navigationTitle("All Matches")
    }
}

struct AllMatchesScreen_Previews: PreviewProvider {
    static var previews: some View {
        AllMatchesScreen()
    }
}
