//
//  NewMessageView.swift
//  twitter
//
//  Created by 신동규 on 2021/11/17.
//

import SwiftUI

struct NewMessageView: View {
    @State var searchTest: String = ""
    @Binding var isShowingNewMessageView: Bool
    @Binding var startChat: Bool
    
    var body: some View {
        ScrollView {
            SearchBar(text: $searchTest)
                .padding(.top)
            VStack {
                ForEach(0..<20) { _ in
                    Button {
                        self.isShowingNewMessageView.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.startChat.toggle()
                        }
                    } label: {
                        UserCell()
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
        NewMessageView(isShowingNewMessageView: .constant(true), startChat: .constant(false))
    }
}
