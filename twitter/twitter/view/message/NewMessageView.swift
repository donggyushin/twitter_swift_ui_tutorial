//
//  NewMessageView.swift
//  twitter
//
//  Created by 신동규 on 2021/11/17.
//

import SwiftUI

struct NewMessageView: View {
    @Binding var isShowingNewMessageView: Bool
    @Binding var userToChat: TwitterUser?
    @ObservedObject var viewModel = ViewModelDependency.resolve().searchViewModelFactory(.EXCLUDE_ME)
    
    var body: some View {
        ScrollView {
            SearchBar(text: $viewModel.searchText)
                .padding(.top)
            VStack {
                ForEach(viewModel.filteredUsers()) { user in
                    Button {
                        self.isShowingNewMessageView.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.userToChat = user
                        }
                    } label: {
                        UserCell(user: user)
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageView(isShowingNewMessageView: .constant(true), userToChat: .constant(nil))
    }
}
