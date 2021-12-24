//
//  ConversationListView.swift
//  twitter
//
//  Created by 신동규 on 2021/11/17.
//

import SwiftUI
import LazyViewSwiftUI

struct ConversationListView: View {
    
    @State var isShowingNewMessageView = false
    @State var startChat = false
    
    @ObservedObject var viewModel: ConversationListViewModel = ViewModelDependency.resolve().conversationListViewModel
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
//            NavigationLink(isActive: $startChat) {
//                ChatView(user: .init(dictionary: [:]))
//            } label: {}

            ScrollView {
                VStack {
                    ForEach(viewModel.recentMessages) { message in
                        NavigationLink {
                            LazyView(ChatView(user: message.user))
                        } label: {
                            ConversationCell(message: message)
                                .padding()
                        }
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
        }.onAppear {
            viewModel.isViewDisplayed = true
            viewModel.fetchRecentMessages()
        }.onDisappear {
            viewModel.isViewDisplayed = false 
        }
    }
}

struct ConversationListView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationListView()
    }
}
