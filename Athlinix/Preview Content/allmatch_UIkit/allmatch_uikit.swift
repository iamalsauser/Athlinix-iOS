import SwiftUI
import UIKit

struct allmatch_uikit: View {
    var body: some View {
        matchview_uikit()
            .edgesIgnoringSafeArea(.all)
    }
}

struct matchview_uikit: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        // Load storyboard
        let storyboard = UIStoryboard(name: "Main2", bundle: nil)
        
        // Directly instantiate view controller
        let controller = storyboard.instantiateViewController(withIdentifier: "Jack")
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // No updates needed in this example
    }
}

struct allmatch_uikit_Previews: PreviewProvider {
    static var previews: some View {
        allmatch_uikit()
            .previewLayout(.sizeThatFits)
            .environment(\.colorScheme, .light)
    }
}
