//
//  ChatRepository.swift
//  twitter
//
//  Created by 신동규 on 2021/12/24.
//
import RxSwift
protocol ChatRepository {
    func sendMessage(messageText: String, to: TwitterUser)
    func fetchRecentMessages() -> Observable<Message>
}
