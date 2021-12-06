//
//  twitterApp.swift
//  twitter
//
//  Created by 신동규 on 2021/11/17.
//

import SwiftUI
import Firebase

@main
struct twitterApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel.shared)
        }
    }
}
