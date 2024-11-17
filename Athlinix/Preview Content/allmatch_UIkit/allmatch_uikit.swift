import SwiftUI
import UIKit

struct allmatch_uikit: View {
    var body: some View {
        matchview_uikit().edgesIgnoringSafeArea(.all)
    }
}

struct matchview_uikit: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        // Use a fallback or mock view if the storyboard fails to load
        let storyboard = UIStoryboard(name: "Main2", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "Jack") as? UIViewController {
            return controller
        } else {
            return UIViewController() // Fallback to an empty view controller if loading fails
        }
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Add updates if needed
    }
}

struct allmatch_uikit_Previews: PreviewProvider {
    static var previews: some View {
        allmatch_uikit()
            .previewLayout(.sizeThatFits)
            .environment(\.colorScheme, .light)  // Optional: Set light/dark mode for preview
    }
}
