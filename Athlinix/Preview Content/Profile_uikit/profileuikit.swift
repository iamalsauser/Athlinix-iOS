//
//  ProfileUIKit.swift
//  Athlinix
//
//  Created by admin17 on 19/11/24.
//

import SwiftUI

struct ProfileUIKit: View {
    var body: some View {
        ProfileUIKitController()
    }
}

struct ProfileUIKitController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main8", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "Parth")
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Leave empty if there's no need for updates
    }
}

#Preview {
    ProfileUIKit()
}
