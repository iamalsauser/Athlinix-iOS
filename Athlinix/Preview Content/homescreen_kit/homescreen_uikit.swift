import SwiftUI

struct homescreen_uikit: View {
    var body: some View {
        home_uikit()
    }
}

struct home_uikit: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let storyboard = UIStoryboard(name: "Main7", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "okay")
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Leave empty if there's no need for updates
    }
}

struct homescreen_uikit_Previews: PreviewProvider {
    static var previews: some View {
        homescreen_uikit()
    }
}
