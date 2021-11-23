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
        
        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child(filename)
        storageRef.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            storageRef.downloadURL { url, _ in
                guard let profileImageUrl = url?.absoluteString else { return }
                
                
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if let error = error {
                        print(error.localizedDescription)
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
                            print(error.localizedDescription)
                            return
                        }
                        
                        print("DEBUG: Successfully uploaded user data...")
                    }
                    
                }
                
            }
        }
        
        
        
    }
}
