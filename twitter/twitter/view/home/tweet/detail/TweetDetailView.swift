//
//  TweetDetailView.swift
//  twitter
//
//  Created by 신동규 on 2021/12/09.
//

import SwiftUI
import Kingfisher

struct TweetDetailView: View {
    
    let tweet: Tweet
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                KFImage(.init(string: tweet.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: 56, height: 56)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(tweet.fullname)
                        .fontWeight(.bold)
                        .font(.system(size: 14))
                    Text("@\(tweet.username)")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            
            Text(tweet.caption)
                .font(.system(size: 20))
            
            Text("7:22 PM • 09/12/2021")
                .foregroundColor(.gray)
                .font(.system(size: 14))
            
            Divider()
            
            HStack {
                HStack(spacing: 2) {
                    Text("0")
                        .fontWeight(.semibold)
                        .font(.system(size: 14))
                    Text("Retweets")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                }
                
                HStack(spacing: 2) {
                    Text("\(tweet.likes)")
                        .fontWeight(.semibold)
                        .font(.system(size: 14))
                    Text("Likes")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                }
            }
            
            Divider()
            TweetActionsView()
            Spacer()
            
        }
        .padding()
    }
}

struct TweetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TweetDetailView(tweet: .init(dictionary: [
            "uid": "asd",
            "username": "username",
            "profileImageUrl": "https://firebasestorage.googleapis.com:443/v0/b/twitter-swift-ui-754b7.appspot.com/o/9CACC08F-0341-4FBD-B7E6-C40BAE58A83B?alt=media&token=3ed1e3aa-41f6-4c89-a750-37ca42d2266b",
            "fullname": "fullname",
            "caption": "captioncaptioncaptioncaptioncaption",
            "likes": 4
        ]))
    }
}
