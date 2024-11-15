//
//  SwiftUIView.swift
//  Athlinix
//
//  Created by admin17 on 15/11/24.
//

import SwiftUI
import UIKit

struct Cert_template: View {
    var body: some View {
        storyboardview().edgesIgnoringSafeArea(.all )
    }
}

struct storyboardview: UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> UIViewController {
        let storyboard=UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(identifier: "Cert")
        return controller
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}
#Preview {
    Cert_template()
}
