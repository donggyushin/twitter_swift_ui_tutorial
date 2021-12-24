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
    @Published var isViewDisplayed = false
    
    @Published var isShowingNewMessageView = false
    @Published var startChat = false
    @Published var userToChat: TwitterUser?
    
    var subscriber: Set<AnyCancellable> = .init()
    
    private let chatRepository: ChatRepository
    private let disposeBag = DisposeBag()
    
    
    init(chatRepository: ChatRepository) {
        self.chatRepository = chatRepository
        listenRecentMessages()
        bind()
    }
    
    private func bind() {
        $userToChat.sink { [weak self] user in
            self?.startChat = user != nil
        }.store(in: &subscriber)
    }
    
    func fetchRecentMessages() {
        chatRepository.fetchRecentMessages().subscribe(onNext: { [weak self] messages in
            self?.recentMessages = messages
        }).disposed(by: disposeBag)
    }
    
    func listenRecentMessages() {
        chatRepository.listenRecentMessages().subscribe(onNext: { [weak self] message in
            if self?.isViewDisplayed == true {
                if let deleteIndex = self?.recentMessages.enumerated().first(where: { $1.user.id == message.user.id }).map ({ $0.offset }) {
                    self?.recentMessages.remove(at: deleteIndex)
                }
                self?.recentMessages.insert(message, at: 0)
            }
        }).disposed(by: disposeBag)
    }
}
