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
    @Published var userTweets: [Tweet] = []
    @Published var likedTweets: [Tweet] = []
    
    let user: TwitterUser
    
    init(user: TwitterUser) {
        self.user = user
        checkIfUserIsFollowed()
        fetchUserTweets()
        fetchLikedTweets()
    }
    
    func follow() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let followingRef = COLLECTION_FOLLOWING.document(currentUid).collection("user-following")
        let follwersRef = COLLECTION_FOLLOWERS.document(user.id).collection("user-followers")
        followingRef.document(user.id).setData([:]) { _ in
            follwersRef.document(currentUid).setData([:]) { _ in
                self.isFollowed = true
            }
        }
    }
    
    func unfollow() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let followingRef = COLLECTION_FOLLOWING.document(currentUid).collection("user-following")
        let follwersRef = COLLECTION_FOLLOWERS.document(user.id).collection("user-followers")
        followingRef.document(user.id).delete { _ in
            follwersRef.document(currentUid).delete { _ in
                self.isFollowed = false
            }
        }
    }
    
    func checkIfUserIsFollowed() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let followingRef = COLLECTION_FOLLOWING.document(currentUid).collection("user-following")
        followingRef.document(user.id).getDocument { snapshot, _ in
            guard let isFollowed = snapshot?.exists else { return }
            self.isFollowed = isFollowed
        }
    }
    
    func fetchUserTweets() {
        COLLECTION_TWEETS.whereField("uid", isEqualTo: user.id).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.userTweets = documents.map({ .init(dictionary: $0.data()) })
        }
    }
    
    func fetchLikedTweets() {
        COLLECTION_USERS.document(user.id).collection("user-likes").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let tweetIds = documents.map({ $0.documentID })
            tweetIds.forEach({
                COLLECTION_TWEETS.document($0).getDocument { snapshot, _ in
                    guard let data = snapshot?.data() else { return }
                    self.likedTweets.append(.init(dictionary: data))
                }
            })
        }
    }
}
