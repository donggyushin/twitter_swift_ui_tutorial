//
//  OtherChatBubble.swift
//  twitter
//
//  Created by 신동규 on 2021/11/18.
//

import SwiftUI
import Kingfisher

struct OtherChatBubble: View {
    
    let message: Message
    
    var body: some View {
        HStack(alignment: .bottom) {
            KFImage(.init(string: message.user.profileImageUrl))
                .resizable()
                .frame(width: 40, height: 40)
                .scaledToFill()
                .clipShape(Circle())
            
            Text(message.text)
                .padding(10)
                .background(Color(UIColor.systemGray6))
                .clipShape(ChatBubbleShape(isFromCurrentUser: false))
            
            Spacer()
        }
        .padding(.leading, 10)
    }
}

struct OtherChatBubble_Previews: PreviewProvider {
    static var previews: some View {
        OtherChatBubble(message: .init(user: .init(dictionary: [
            "email": "test2@gmail.com",
            "fullname": "Shin donggyu",
            "profileImageUrl": "https://firebasestorage.googleapis.com:443/v0/b/twitter-swift-ui-754b7.appspot.com/o/9CACC08F-0341-4FBD-B7E6-C40BAE58A83B?alt=media&token=3ed1e3aa-41f6-4c89-a750-37ca42d2266b",
            "uid": "asd",
            "username": "Spider Man"
        ]), dictionary: [
            "text": "asd",
            "toId": "asd",
            "fromId": "fromId",
            "id": "id"
        ]))
    }
}
