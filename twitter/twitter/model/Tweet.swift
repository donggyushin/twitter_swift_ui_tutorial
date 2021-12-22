//
//  Tweet.swift
//  twitter
//
//  Created by 신동규 on 2021/12/08.
//

import Firebase

let TWEET_ARRAY_USERDEFAULTS_KEY = "TWEET_ARRAY_USERDEFAULTS_KEY"

struct Tweet: Identifiable, Codable {
    let id: String
    let username: String
    let profileImageUrl: String
    let fullname: String
    let caption: String
    let likes: Int
    let uid: String
    let date: Date
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.uid = dictionary["uid"] as? String ?? ""
        self.date = .init(timeIntervalSince1970: Double((dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())).seconds))
    }
    
    static func getTweetArrayFromUserDefaults() -> [Tweet] {
        var tweets: [Tweet] = []
        let defaults = UserDefaults.standard
        if let savedTweets = defaults.object(forKey: TWEET_ARRAY_USERDEFAULTS_KEY) as? Data {
            let decoder = JSONDecoder()
            if let loadedTweetArray = try? decoder.decode([Tweet].self, from: savedTweets) {
                tweets = loadedTweetArray
            }
        }
        tweets = tweets.filter({ $0.id.isEmpty == false })
        return tweets
    }
}

extension Array where Element == Tweet {
    
    func saveUserDefaults() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: TWEET_ARRAY_USERDEFAULTS_KEY)
        }
    }
}
