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
    
    private let chatRepository: ChatRepository
    private let disposeBag = DisposeBag()
    
    init(chatRepository: ChatRepository) {
        self.chatRepository = chatRepository
        fetchRecentMessages()
    }
    
    func fetchRecentMessages() {
        chatRepository.fetchRecentMessages().subscribe(onNext: { [weak self] message in
            self?.recentMessages.append(message)
//            self?.recentMessages.append(contentsOf: messages)
        }).disposed(by: disposeBag)
    }
}
