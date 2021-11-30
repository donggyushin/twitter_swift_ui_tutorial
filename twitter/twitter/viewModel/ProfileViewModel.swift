//
//  ProfileViewModel.swift
//  twitter
//
//  Created by 신동규 on 2021/11/30.
//

import SwiftUI
import Firebase

class ProfileViewModel: ObservableObject {
    @Published var isFollowed = false
    let user: TwitterUser
    
    init(user: TwitterUser) {
        self.user = user
    }
    
    func follow() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(user.id).setData([:]) { _ in
            COLLECTION_FOLLOWERS.document(self.user.id).collection("user-followers").document(currentUid).setData([:]) { _ in
                self.isFollowed = true
            }
        }
    }
    
    func unfollow() {
        
    }
}
