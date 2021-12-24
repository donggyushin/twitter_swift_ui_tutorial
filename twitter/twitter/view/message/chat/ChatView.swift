//
//  ChatView.swift
//  twitter
//
//  Created by 신동규 on 2021/11/17.
//

import SwiftUI

struct ChatView: View {
    
    @State var messageText: String = ""
    @ObservedObject var viewModel: ChatViewModel
    
    init(user: TwitterUser) {
        self.viewModel = ViewModelDependency.resolve().chatViewModelFactory(user)
    }
    
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
            MessageInputView(messageText: $messageText, action: { messageText in 
                viewModel.sendMessages(messageText: messageText)
            })
                .padding()
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(user: .init(dictionary: [
            "uid": "asd",
            "email": "test2@gmail.com",
            "fullname": "shin donggyu",
            "username": "batman",
            "profileImageUrl": "https://firebasestorage.googleapis.com:443/v0/b/twitter-swift-ui-754b7.appspot.com/o/9CACC08F-0341-4FBD-B7E6-C40BAE58A83B?alt=media&token=3ed1e3aa-41f6-4c89-a750-37ca42d2266b"
        ]))
    }
}
