//
//  TwitterUser.swift
//  twitter
//
//  Created by 신동규 on 2021/11/25.
//

import Firebase

struct TwitterUser: Identifiable {
    let id: String
    let username: String
    let profileImageUrl: String
    let fullname: String
    let email: String
    var isMe: Bool { return Auth.auth().currentUser?.uid == self.id }
    var stats: Stats = .init(followers: 0, following: 0)
    var isFollowed = false
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["uid"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
    
    func fetchStats(completion: @escaping (Stats) -> Void) {
        let followingRef = COLLECTION_FOLLOWING.document(self.id).collection("user-following")
        let followersRef = COLLECTION_FOLLOWERS.document(self.id).collection("user-followers")
        
        followersRef.getDocuments { snapshot, _ in
            let followers = snapshot?.count ?? 0
            followingRef.getDocuments { snapshot, _ in
                let following = snapshot?.count ?? 0
                completion(.init(followers: followers, following: following))
            }
        }
    }
    
    func checkIsFollowed(completion: @escaping(Bool) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else {
            completion(false)
            return }
        let followingRef = COLLECTION_FOLLOWING.document(currentUid).collection("user-following")
        followingRef.document(self.id).getDocument { snapshot, _ in
            let isFolllowed = snapshot?.exists ?? false
            completion(isFolllowed)
        }
    }
    
    func fetchTweets(completion: @escaping([Tweet]) -> Void) {
        COLLECTION_TWEETS.whereField("uid", isEqualTo: self.id).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else {
                completion([])
                return
            }
            completion(documents.map({ Tweet(dictionary: $0.data()) }))
        }
    }
    
    func fetchLikedTweets(completion: @escaping([Tweet]) -> Void) {
        var tweets: [Tweet] = []
        COLLECTION_USERS.document(self.id).collection("user-likes").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else {
                completion(tweets)
                return }
            let tweetIds = documents.map({ $0.documentID })
            tweetIds.forEach({
                COLLECTION_TWEETS.document($0).getDocument { snapshot, _ in
                    guard let data = snapshot?.data() else { return }
                    tweets.append(.init(dictionary: data))
                    if tweets.count == tweetIds.count {
                        completion(tweets)
                    }
                }
            })
        }
    }
    
    struct Stats {
        let followers: Int
        let following: Int
    }
}
