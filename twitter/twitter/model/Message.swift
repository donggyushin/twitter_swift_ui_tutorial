//
//  Message.swift
//  twitter
//
//  Created by 신동규 on 2021/11/18.
//

import Firebase

let RECENT_MESSAGES_USERDEFAULTS_KEY = "RECENT_MESSAGES_USERDEFAULTS_KEY"

struct Message: Identifiable, Equatable, Codable {
    static func == (lhs: Message, rhs: Message) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: String
    let text: String
    let user: TwitterUser
    let toId: String
    let fromId: String
    var isFromCurrentUser: Bool
    let date: Date
    
    var chatPartnerId: String { isFromCurrentUser ? toId : fromId }
    
    init(user: TwitterUser, dictionary: [String: Any]) {
        self.user = user
        
        self.text = dictionary["text"] as? String ?? ""
        self.toId = dictionary["toId"] as? String ?? ""
        self.fromId = dictionary["fromId"] as? String ?? ""
        self.isFromCurrentUser = fromId == Auth.auth().currentUser?.uid
        let timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.date = timestamp.dateValue()
        self.id = dictionary["id"] as? String ?? ""
    }
    
    static func getRecentMessagesToUserDefaults() -> [Message] {
        var messages: [Message] = []
        let defaults = UserDefaults.standard
        if let savedMessages = defaults.object(forKey: RECENT_MESSAGES_USERDEFAULTS_KEY) as? Data {
            let decoder = JSONDecoder()
            if let loadedMessageArray = try? decoder.decode([Message].self, from: savedMessages) {
                messages = loadedMessageArray
            }
        }
        messages = messages.filter({ $0.id.isEmpty == false })
        return messages
    }
}

extension Array where Element == Message {
    func saveRecentMessagesToUserDefaults() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: RECENT_MESSAGES_USERDEFAULTS_KEY)
        }
    }
}
