//
//  ProfileViewModel.swift
//  twitter
//
//  Created by 신동규 on 2021/11/30.
//

import SwiftUI
import Firebase

class ProfileViewModel: ObservableObject {
    @Published var userTweets: [Tweet] = []
    @Published var likedTweets: [Tweet] = []
    @Published var user: TwitterUser
    
    init(user: TwitterUser) {
        self.user = user
        checkIfUserIsFollowed()
        fetchUserTweets()
        fetchLikedTweets()
        updateUserStats()
    }
    
    func follow() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let followingRef = COLLECTION_FOLLOWING.document(currentUid).collection("user-following")
        let follwersRef = COLLECTION_FOLLOWERS.document(user.id).collection("user-followers")
        followingRef.document(user.id).setData([:]) { _ in
            follwersRef.document(currentUid).setData([:]) { _ in
                self.user.isFollowed = true
            }
        }
    }
    
    func unfollow() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let followingRef = COLLECTION_FOLLOWING.document(currentUid).collection("user-following")
        let follwersRef = COLLECTION_FOLLOWERS.document(user.id).collection("user-followers")
        followingRef.document(user.id).delete { _ in
            follwersRef.document(currentUid).delete { _ in
                self.user.isFollowed = false
            }
        }
    }
    
    func tweets(filter: TweetFilterOptions) -> [Tweet] {
        switch filter {
        case .tweets: return self.userTweets
        case .likes: return self.likedTweets
        case .replies: return []
        }
    }
    
    private func updateUserStats() {
        user.fetchStats { stats in
            self.user.stats = stats
        }
    }
    
    private func checkIfUserIsFollowed() {
        self.user.checkIsFollowed { isFollowed in
            self.user.isFollowed = isFollowed
        }
    }
    
    private func fetchUserTweets() {
        user.fetchTweets { tweets in
            self.userTweets = tweets
        }
    }
    
    private func fetchLikedTweets() {
        user.fetchLikedTweets { tweets in
            self.likedTweets = tweets
        }
    }
}
