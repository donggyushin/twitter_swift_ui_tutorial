//
//  TweetActionsView.swift
//  twitter
//
//  Created by 신동규 on 2021/12/09.
//

import SwiftUI

struct TweetActionsView: View {
    @ObservedObject var viewModel: TweetActionViewModel
    
    init(tweet: Tweet) {
        viewModel = .init(tweet: tweet)
    }
    
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
                viewModel.didLike ? viewModel.unlikeTweet() : viewModel.likeTweet()
            } label: {
                Image(systemName: viewModel.didLike ? "heart.fill" : "heart")
                    .foregroundColor(viewModel.didLike ? .red : .gray)
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
        TweetActionsView(tweet: .init(dictionary: [
            "uid": "asd",
            "username": "username",
            "profileImageUrl": "https://firebasestorage.googleapis.com:443/v0/b/twitter-swift-ui-754b7.appspot.com/o/9CACC08F-0341-4FBD-B7E6-C40BAE58A83B?alt=media&token=3ed1e3aa-41f6-4c89-a750-37ca42d2266b",
            "fullname": "fullname",
            "caption": "captioncaptioncaptioncaptioncaption",
            "likes": 4
        ]))
    }
}
