//
//  TweetActionsView.swift
//  twitter
//
//  Created by 신동규 on 2021/12/09.
//

import SwiftUI

struct TweetActionsView: View {
    var body: some View {
        HStack {
            Button {
                print("nothing")
            } label: {
                Image(systemName: "bubble.left")
            }
            Spacer()
            Button {
                print("nothing")
            } label: {
                Image(systemName: "arrow.2.squarepath")
            }
            Spacer()
            Button {
                print("nothing")
            } label: {
                Image(systemName: "heart")
            }
            Spacer()
            Button {
                print("nothing")
            } label: {
                Image(systemName: "bookmark")
            }
        }
        .padding(.top, 10)
        .foregroundColor(.gray)
        .padding(.horizontal)
    }
}

struct TweetActionsView_Previews: PreviewProvider {
    static var previews: some View {
        TweetActionsView()
    }
}
