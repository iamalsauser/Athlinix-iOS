//
//  exploreui.swift
//  Athlinix
//
//  Created by admin17 on 17/11/24.
//

import SwiftUI

struct exploreui: View {
    var body: some View {
        Explore_UIkit().edgesIgnoringSafeArea(.all)
    }
}
struct Explore_UIkit: UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> UIViewController {
        let storyboard=UIStoryboard(name: "Main4", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "view") as! viewui
        return controller
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}
#Preview {
    exploreui()
}
