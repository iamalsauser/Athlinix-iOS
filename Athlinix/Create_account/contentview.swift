//
//  contentview.swift
//  Athlinix
//
//  Created by admin17 on 13/12/24.
//

import SwiftUI

struct ContentView_: View {
    @State private var selectedButton: String = "login"

    var body: some View {
        if selectedButton == "login" {
            LoginScreen(selectedButton: $selectedButton)
        } else if selectedButton == "createAccount" {
            CreateAccountScreen(selectedButton: $selectedButton)
        }else if selectedButton == "home" {
            HomeScreen(selectedButton: $selectedButton) // Navigate to PhoneNumberScreen
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView_()
    }
}
