//
//  ConversationListView.swift
//  twitter
//
//  Created by 신동규 on 2021/11/17.
//

import SwiftUI
import LazyViewSwiftUI

struct ConversationListView: View {
    @ObservedObject var viewModel: ConversationListViewModel = ViewModelDependency.resolve().conversationListViewModel
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            NavigationLink(isActive: $viewModel.startChat) {
                if let user = viewModel.userToChat {
                    LazyView(ChatView(user: user))
                }
            } label: {}

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
                viewModel.isShowingNewMessageView.toggle()
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
            .sheet(isPresented: $viewModel.isShowingNewMessageView) {
                NewMessageView(isShowingNewMessageView: $viewModel.isShowingNewMessageView, userToChat: $viewModel.userToChat)
            }
        }.onAppear {
            viewModel.fetchRecentMessages()
            viewModel.isPresent = true
        }.onDisappear {
            viewModel.isPresent = false
        }
    }
}

//struct ConversationListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConversationListView()
//    }
//}
