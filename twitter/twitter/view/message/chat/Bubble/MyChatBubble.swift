//
//  MyChatBubble.swift
//  twitter
//
//  Created by 신동규 on 2021/11/18.
//

import SwiftUI

struct ChatBubbleShape: Shape {
    
    let isFromCurrentUser: Bool
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight, isFromCurrentUser ? .bottomLeft : .bottomRight], cornerRadii: .init(width: 16, height: 16))
        
        return .init(path.cgPath)
    }
}

struct MyChatBubble: View {
    
    let message: Message
    
    var body: some View {
        HStack {
            Spacer()
            Text(message.text)
                .padding(10)
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(ChatBubbleShape(isFromCurrentUser: true))
                .padding(.trailing, 10)
        }
    }
}

struct MyChatBubble_Previews: PreviewProvider {
    static var previews: some View {
        MyChatBubble(message: .init(user: .init(dictionary: [
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
