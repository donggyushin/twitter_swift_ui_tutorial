//
//  ChatRepositoryImpl.swift
//  twitter
//
//  Created by 신동규 on 2021/12/24.
//
import Firebase
import RxSwift

class ChatRepositoryImpl: ChatRepository {
    
    private let RECENT_MESSAGES = "recent-messages"
    
    func fetchRecentMessages() -> Observable<[Message]> {
        return .create { observer in
            guard let uid = Auth.auth().currentUser?.uid else { return Disposables.create() }
            let query = COLLECTION_MESSAGES.document(uid).collection(self.RECENT_MESSAGES)
            query.order(by: "timestamp", descending: false).getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                var messages: [Message] = []
                documents.forEach { document in
                    let messageData = document.data()
                    let uid = document.documentID
                    COLLECTION_USERS.document(uid).getDocument { snapshot, _ in
                        guard let data = snapshot?.data() else { return }
                        let user: TwitterUser = .init(dictionary: data)
                        messages.append(.init(user: user, dictionary: messageData))
                        if messages.count == documents.count {
                            observer.onNext(messages)
                            observer.onCompleted()
                        }
                    }
                }
            }
            
            return Disposables.create()
        }
    }
    
    func listenMessages(user: TwitterUser) -> Observable<[Message]> {
        return .create { observer in
            
            guard let uid = Auth.auth().currentUser?.uid else { return Disposables.create() }
            let query = COLLECTION_MESSAGES.document(uid).collection(user.id)
            query.order(by: "timestamp", descending: false).addSnapshotListener { snapshot, _ in
                guard let changes = snapshot?.documentChanges else { return }
                var messages: [Message] = []
                
                changes.forEach { change in
                    let messageData = change.document.data()
                    guard let fromId = messageData["fromId"] as? String else { return }
                    
                    COLLECTION_USERS.document(fromId).getDocument { snapshot, _ in
                        guard let data = snapshot?.data() else { return }
                        let user: TwitterUser = .init(dictionary: data)
                        messages.append(.init(user: user, dictionary: messageData))
                        if messages.count == changes.count {
                            messages.sort(by: { $0.date.timeIntervalSince1970 < $1.date.timeIntervalSince1970 })
                            observer.onNext(messages)
                        }
                    }
                }
            }
            
            return Disposables.create()
        }
    }
    
    func listenRecentMessages() -> Observable<[Message]> {
        return .create { observer in
            
            guard let uid = Auth.auth().currentUser?.uid else { return Disposables.create() }
            let query = COLLECTION_MESSAGES.document(uid).collection(self.RECENT_MESSAGES)
            query.order(by: "timestamp", descending: false).addSnapshotListener { snapshot, error in
                guard let changes = snapshot?.documentChanges else { return }
                var messages: [Message] = []
                changes.forEach { change in
                    let messageData = change.document.data()
                    let uid = change.document.documentID
                    
                    COLLECTION_USERS.document(uid).getDocument { snapshot, _ in
                        guard let data = snapshot?.data() else { return }
                        let user: TwitterUser = .init(dictionary: data)
                        messages.append(.init(user: user, dictionary: messageData))
                        if changes.count == messages.count {
                            messages.sort(by: { $0.date.timeIntervalSince1970 > $1.date.timeIntervalSince1970 })
                            observer.onNext(messages)
                        }
                    }
                }
            }
            return Disposables.create()
        }
    }
    
    
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
