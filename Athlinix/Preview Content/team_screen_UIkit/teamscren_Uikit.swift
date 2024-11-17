//
//  allmatch_uikit.swift
//  Athlinix
//
//  Created by admin17 on 17/11/24.
//

import SwiftUI
import UIKit

struct teamscreen_uikit: View {
    var body: some View {
        Teamview_uikit().edgesIgnoringSafeArea(.all)
    }
}
struct Teamview_uikit: UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> UIViewController {
        let storyboard=UIStoryboard(name: "Main3", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(identifier: "Team")
        return controller
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

#Preview {
    teamscreen_uikit()
}
