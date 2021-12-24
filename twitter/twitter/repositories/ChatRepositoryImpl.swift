//
//  ChatRepositoryImpl.swift
//  twitter
//
//  Created by 신동규 on 2021/12/24.
//
import Firebase

class ChatRepositoryImpl: ChatRepository {
    
    private let RECENT_MESSAGES = "recent-messages"
    
    func sendMessage(messageText: String, to: TwitterUser) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let currentUserRef = COLLECTION_MESSAGES.document(currentUid).collection(to.id).document()
        let receivingUserRef = COLLECTION_MESSAGES.document(to.id).collection(currentUid)
        
        let currentUserRecentRef = COLLECTION_MESSAGES.document(currentUid).collection(RECENT_MESSAGES)
        let receivingRecentRef = COLLECTION_MESSAGES.document(to.id).collection(RECENT_MESSAGES)
        
        let messageID = currentUserRef.documentID
        
        let data: [String: Any] = [
            "text": messageText,
            "id": messageID,
            "fromId": currentUid,
            "toId": to.id,
            "timestamp": Timestamp(date: Date())
        ]
        
        currentUserRef.setData(data)
        receivingUserRef.document(messageID).setData(data)
        
        currentUserRecentRef.document(to.id).setData(data)
        receivingRecentRef.document(currentUid).setData(data)
    }
}
