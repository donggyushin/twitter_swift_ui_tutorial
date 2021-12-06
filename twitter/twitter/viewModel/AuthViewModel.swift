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
    
    @Published var userSession: User?
    @Published var isAuthenticating = false
    @Published var error: Error?
    @Published var user: TwitterUser?
    
    static let shared = AuthViewModel()
    
    init() {
        self.userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func signOut() {
        self.userSession = nil
        try? Auth.auth().signOut()
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.error = error
                return
            }
            self.userSession = result?.user
            self.user = nil 
            self.fetchUser()
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
                        "username": username.lowercased(),
                        "profileImageUrl": profileImageUrl,
                        "uid": user.uid
                    ]
                    
                    Firestore.firestore().collection("users").document(user.uid).setData(data) { error in
                        self.userSession = user
                        self.fetchUser()
                        if let error = error {
                            self.error = error
                            return
                        }
                    }
                    
                }
                
            }
        }
    }
    
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
            guard let data = snapshot?.data() else { return }
            let user: TwitterUser = .init(dictionary: data)
            self.user = user
            print("DEBUG: user: \(user.fullname)")
        }
    }
}
