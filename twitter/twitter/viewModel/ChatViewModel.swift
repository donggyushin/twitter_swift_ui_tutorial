//
//  ChatViewModel.swift
//  twitter
//
//  Created by 신동규 on 2021/12/24.
//

import SwiftUI
import RxSwift

class ChatViewModel: ObservableObject {
    
    @Published var messages: [Message] = []
    @Published var messageText: String = ""
    
    private let chatRepository: ChatRepository
    private let disposeBag = DisposeBag()
    let user: TwitterUser
    
    init(user: TwitterUser, chatRepository: ChatRepository) {
        self.user = user
        self.chatRepository = chatRepository
        fetchMessages()
    }
    
    private func fetchMessages() {
        chatRepository.listenMessages(user: user).subscribe(onNext: { [weak self] messages in
            self?.messages.append(contentsOf: messages)
        }).disposed(by: disposeBag)
    }
    
    func sendMessages() {
        chatRepository.sendMessage(messageText: messageText, to: user)
        messageText = "" 
    }
}
