//
//  OtherChatBubble.swift
//  twitter
//
//  Created by 신동규 on 2021/11/18.
//

import SwiftUI

struct OtherChatBubble: View {
    var body: some View {
        HStack(alignment: .bottom) {
            Image("batman")
                .resizable()
                .frame(width: 40, height: 40)
                .scaledToFill()
                .clipShape(Circle())
            
            Text("Hi There.")
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
        OtherChatBubble()
    }
}
