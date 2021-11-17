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
    var body: some View {
        HStack {
            Spacer()
            Text("Hellow There!")
                .padding(10)
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(ChatBubbleShape(isFromCurrentUser: true))
                .padding(.trailing, 5)
        }
    }
}

struct MyChatBubble_Previews: PreviewProvider {
    static var previews: some View {
        MyChatBubble()
    }
}
