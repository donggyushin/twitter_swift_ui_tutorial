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
    
    struct Stats {
        let followers: Int
        let following: Int
    }
}
