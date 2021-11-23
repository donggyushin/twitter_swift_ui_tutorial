//
//  AuthViewModel.swift
//  twitter
//
//  Created by 신동규 on 2021/11/23.
//

import SwiftUI
import UIKit
import Firebase

class AuthViewModel: ObservableObject {
    func login() {
        
    }
    
    func registerUser(email: String, password: String, username: String, fullname: String, profileImage: UIImage) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("DEBUG: Successfully signed up user..")
            }
        }
    }
}
