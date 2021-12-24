//
//  ConversationListViewModel.swift
//  twitter
//
//  Created by 신동규 on 2021/12/24.
//

import SwiftUI
import RxSwift

class ConversationListViewModel: ObservableObject {
    @Published var recentMessages: [Message] = []
    @Published var isViewDisplayed = false
    
    private let chatRepository: ChatRepository
    private let disposeBag = DisposeBag()
    
    
    init(chatRepository: ChatRepository) {
        self.chatRepository = chatRepository
        listenRecentMessages()
    }
    
    func fetchRecentMessages() {
        chatRepository.fetchRecentMessages().subscribe(onNext: { [weak self] messages in
            self?.recentMessages = messages
        }).disposed(by: disposeBag)
    }
    
    func listenRecentMessages() {
        chatRepository.listenRecentMessages().subscribe(onNext: { [weak self] messages in
            if self?.isViewDisplayed == true {
                self?.recentMessages = messages
            }
        }).disposed(by: disposeBag)
    }
}
