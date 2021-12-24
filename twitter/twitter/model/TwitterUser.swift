//
//  TwitterUser.swift
//  twitter
//
//  Created by 신동규 on 2021/11/25.
//

import Firebase

let TWITTER_USER_USERDEFAULTS_KEY = "TWITTER_USER_USERDEFAULTS_KEY"

struct TwitterUser: Identifiable, Codable {
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
    
    struct Stats: Codable {
        let followers: Int
        let following: Int
    }
    
    static func getFromUserdefaults() -> [TwitterUser] {
        var users: [TwitterUser] = []
        let defaults = UserDefaults.standard
        if let savedUsers = defaults.object(forKey: TWITTER_USER_USERDEFAULTS_KEY) as? Data {
            let decoder = JSONDecoder()
            if let loadedUserArray = try? decoder.decode([TwitterUser].self, from: savedUsers) {
                users = loadedUserArray
            }
        }
        users = users.filter({ $0.id.isEmpty == false })
        return users
    }
}

extension Array where Element == TwitterUser {
    func saveToUserDefaults() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: TWITTER_USER_USERDEFAULTS_KEY)
        }
    }
}
