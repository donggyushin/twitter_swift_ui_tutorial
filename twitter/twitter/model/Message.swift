//
//  Message.swift
//  twitter
//
//  Created by 신동규 on 2021/11/18.
//

import Firebase

struct Message: Identifiable, Equatable {
    static func == (lhs: Message, rhs: Message) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: String
    let text: String
    let user: TwitterUser
    let toId: String
    let fromId: String
    var isFromCurrentUser: Bool
    let timestamp: Timestamp
    
    var chatPartnerId: String { isFromCurrentUser ? toId : fromId }
    
    init(user: TwitterUser, dictionary: [String: Any]) {
        self.user = user
        
        self.text = dictionary["text"] as? String ?? ""
        self.toId = dictionary["toId"] as? String ?? ""
        self.fromId = dictionary["fromId"] as? String ?? ""
        self.isFromCurrentUser = fromId == Auth.auth().currentUser?.uid
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.id = dictionary["id"] as? String ?? ""
    }
}
