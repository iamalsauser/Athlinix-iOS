//
//  analysisuikit.swift
//  Athlinix
//
//  Created by admin17 on 20/11/24.
//

import SwiftUI

struct analysisuikit: View {
    var body: some View {
        analysisUIKIT()
    }
}
struct analysisUIKIT: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let storyboard = UIStoryboard(name: "Main10", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "Akshita")
        return controller
    }}
    
    #Preview {
        analysisuikit()
    }

