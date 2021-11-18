//
//  ChatView.swift
//  twitter
//
//  Created by 신동규 on 2021/11/17.
//

import SwiftUI

struct ChatView: View {
    
    @State var messageText: String = ""
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(MOCK_MESSAGES_DATA) { message in
                    if message.isFromCurrentUser {
                        MyChatBubble(message: message)
                    } else {
                        OtherChatBubble(message: message)
                    }
                }
            }
            MessageInputView(messageText: $messageText)
                .padding()
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
