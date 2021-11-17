//
//  ConversationListView.swift
//  twitter
//
//  Created by 신동규 on 2021/11/17.
//

import SwiftUI

struct ConversationListView: View {
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                ForEach(0..<20) { _ in
                    ConversationCell()
                        .padding(.horizontal)
                }
            }
            
            Button {
                print("nothing")
            } label: {
                Image("tweet")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 32, height: 32)
                    .padding()
            }
            .background(Color(.systemBlue))
            .foregroundColor(Color.white)
            .clipShape(Circle())
            .padding()
        }
    }
}

struct ConversationListView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationListView()
    }
}
