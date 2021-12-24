//
//  ConversationListView.swift
//  twitter
//
//  Created by 신동규 on 2021/11/17.
//

import SwiftUI

struct ConversationListView: View {
    
    @State var isShowingNewMessageView = false
    @State var startChat = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
//            NavigationLink(isActive: $startChat) {
//                ChatView(user: .init(dictionary: [:]))
//            } label: {}

            ScrollView {
                VStack {
                    ForEach(0..<20) { _ in
//                        NavigationLink {
//                            ChatView(user: .init(dictionary: [:]))
//                        } label: {
//                            ConversationCell()
//                                .padding()
//                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 1)
            
            
            Button {
                self.isShowingNewMessageView.toggle()
            } label: {
                Image(systemName: "envelope")
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .padding()
                    
            }
            .background(Color(.systemBlue))
            .foregroundColor(Color.white)
            .clipShape(Circle())
            .padding()
            .sheet(isPresented: $isShowingNewMessageView) {
                NewMessageView(isShowingNewMessageView: $isShowingNewMessageView, startChat: $startChat)
            }
        }
    }
}

struct ConversationListView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationListView()
    }
}
