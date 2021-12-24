//
//  ChatRepositoryTest.swift
//  twitter
//
//  Created by 신동규 on 2021/12/24.
//
import RxSwift
class ChatRepositoryTest: ChatRepository {
    func fetchRecentMessages() -> Observable<[Message]> {
        return .create { observer in
            observer.onNext([])
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func listenRecentMessages() -> Observable<[Message]> {
        return .create { observer in
            observer.onNext([])
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func sendMessage(messageText: String, to: TwitterUser) {}
}
