//
//  approvalui.swift
//  Athlinix
//
//  Created by admin17 on 19/11/24.
//

import SwiftUI

struct approvalui: View {
    var body: some View {
        Approval()
    }
}
struct Approval:UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let storyboard = UIStoryboard(name: "Main9", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "ApprovalCell")
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Leave empty if there's no need for updates
    }
}

#Preview {
    approvalui()
}
