//
//  matchesui.swift
//  Athlinix
//
//  Created by admin17 on 18/11/24.
//

import SwiftUI

struct matchesui: View {
    var body: some View {
        matches_uikit()
    }
}
struct matches_uikit: UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> UIViewController {
        let storyboard=UIStoryboard(name: "Main5", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "Matches") as! UIkit
        return controller
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}
#Preview {
    matchesui()
}
