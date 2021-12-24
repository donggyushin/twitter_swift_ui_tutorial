//
//  ChatViewModel.swift
//  twitter
//
//  Created by 신동규 on 2021/12/24.
//

import SwiftUI

class ChatViewModel: ObservableObject {
    
    private let chatRepository: ChatRepository
    let user: TwitterUser
    
    init(user: TwitterUser, chatRepository: ChatRepository) {
        self.user = user
        self.chatRepository = chatRepository
        fetchMessages()
    }
    
    func fetchMessages() {
        
    }
    
    func sendMessages(messageText: String) {
        chatRepository.sendMessage(messageText: messageText, to: user)
    }
}
