//
//  TweetActionViewModel.swift
//  twitter
//
//  Created by 신동규 on 2021/12/10.
//

import SwiftUI
import Firebase

class TweetActionViewModel: ObservableObject {
    let tweet: Tweet
    @Published var didLike = false
    
    init(tweet: Tweet) {
        self.tweet = tweet
        guard let uid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_TWEETS.document(tweet.id).collection("tweet-likes").document(uid).getDocument { snapshot, _ in
            self.didLike = snapshot?.data() != nil
        }
    }
    
    func likeTweet() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let tweetLikesRef = COLLECTION_TWEETS.document(tweet.id).collection("tweet-likes")
        let userLikesRef = COLLECTION_USERS.document(uid).collection("user-likes")
        
        tweetLikesRef.document(uid).setData([:]) { _ in
            COLLECTION_TWEETS.document(self.tweet.id).updateData(["likes": self.tweet.likes + 1]) { _ in
                userLikesRef.document(self.tweet.id).setData([:]) { _ in
                    self.didLike = true
                }
            }
        }
    }
    
    func unlikeTweet() {
        
    }
}
