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
    
    @Published var user: User?
    @Published var isAuthenticating = false
    @Published var error: Error?
    
    init() {
        self.user = Auth.auth().currentUser
    }
    
    func signOut() {
        self.user = nil
        try? Auth.auth().signOut()
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.error = error
                return
            }
            
            print("DEBUG: Successfully logged in..")
        }
    }
    
    func registerUser(email: String, password: String, username: String, fullname: String, profileImage: UIImage) {
        
        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child(filename)
        storageRef.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                self.error = error
                return
            }
            
            storageRef.downloadURL { url, _ in
                guard let profileImageUrl = url?.absoluteString else { return }
                
                
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if let error = error {
                        self.error = error
                        return
                    }
                    
                    guard let user = result?.user else { return }
                    
                    let data: [String: Any] = [
                        "email": email,
                        "fullname": fullname,
                        "username": username,
                        "profileImageUrl": profileImageUrl,
                        "uid": user.uid
                    ]
                    
                    Firestore.firestore().collection("users").document(user.uid).setData(data) { error in
                        if let error = error {
                            self.error = error
                            return
                        }
                        
                        print("DEBUG: Successfully uploaded user data...")
                    }
                    
                }
                
            }
        }
        
        
        
    }
}
