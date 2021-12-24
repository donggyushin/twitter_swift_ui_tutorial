//
//  MessageInputView.swift
//  twitter
//
//  Created by 신동규 on 2021/11/17.
//

import SwiftUI

struct MessageInputView: View {
    
    @Binding var messageText: String
    let action: (String) -> Void
    
    var body: some View {
        HStack {
            TextField("Message...", text: $messageText)
                .frame(minHeight: 30)
            
            Button {
                action(messageText)
                messageText = ""
            } label: {
                Text("Send")
            }

        }
    }
}

struct MessageInputView_Previews: PreviewProvider {
    static var previews: some View {
        MessageInputView(messageText: .constant("message"), action: { _ in })
    }
}
