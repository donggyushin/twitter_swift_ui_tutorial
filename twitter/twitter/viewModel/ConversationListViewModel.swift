//
//  ConversationListViewModel.swift
//  twitter
//
//  Created by 신동규 on 2021/12/24.
//

import SwiftUI
import RxSwift
import Combine

class ConversationListViewModel: ObservableObject {
    @Published var recentMessages: [Message] = []
    @Published var isShowingNewMessageView = false
    @Published var startChat = false
    @Published var userToChat: TwitterUser?
    
    var isPresent = false
    
    private var subscriber: Set<AnyCancellable> = .init()
    private let chatRepository: ChatRepository
    private let disposeBag = DisposeBag()
    
    init(chatRepository: ChatRepository) {
        self.chatRepository = chatRepository
        getRecentMessagesFromUserdefaults()
        fetchRecentMessages()
        listenRecentMessages()
        bind()
    }
    
    private func bind() {
        $userToChat.sink { [weak self] user in
            self?.startChat = user != nil
        }.store(in: &subscriber)
        
        $recentMessages.sink { messages in
            if messages.isEmpty == false { messages.saveRecentMessagesToUserDefaults() }
        }.store(in: &subscriber)
    }
    
    private func getRecentMessagesFromUserdefaults() {
        self.recentMessages = Message.getRecentMessagesToUserDefaults()
    }
    
    func fetchRecentMessages() {
        chatRepository.fetchRecentMessages().subscribe(onNext: { [weak self] messages in
            self?.recentMessages = messages
        }).disposed(by: disposeBag)
    }
    
    private func listenRecentMessages() {
        chatRepository.listenRecentMessages().subscribe(onNext: { [weak self] messages in
            if self?.isPresent == true {
                let user_ids_that_came_from_new_messages = messages.map({ $0.user.id })
                var new_recentMessages = (self?.recentMessages.filter({ !user_ids_that_came_from_new_messages.contains($0.user.id) }) ?? [])
                new_recentMessages.insert(contentsOf: messages, at: 0)
                self?.recentMessages = new_recentMessages
            }
        }).disposed(by: disposeBag)
    }
}
