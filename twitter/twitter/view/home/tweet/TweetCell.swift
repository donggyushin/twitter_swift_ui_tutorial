//
//  TweetCell.swift
//  twitter
//
//  Created by 신동규 on 2021/11/17.
//

import SwiftUI
import Kingfisher

struct TweetCell: View {
    
    let tweet: Tweet
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                KFImage(.init(string: tweet.profileImageUrl))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 56, height: 56)
                    .clipShape(Circle())
                    
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(tweet.fullname)
                            .font(Font.system(size: 14, weight: .semibold))
                        
                        Text("@\(tweet.username) • 2w")
                            .foregroundColor(.gray)
                        
                    }
                    
                    Text(tweet.caption)
                }
                Spacer()
            }
            
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
}

struct TweetCell_Previews: PreviewProvider {
    static var previews: some View {
        TweetCell(tweet: .init(dictionary: [
            "uid": "asd",
            "username": "username",
            "profileImageUrl": "https://firebasestorage.googleapis.com:443/v0/b/twitter-swift-ui-754b7.appspot.com/o/9CACC08F-0341-4FBD-B7E6-C40BAE58A83B?alt=media&token=3ed1e3aa-41f6-4c89-a750-37ca42d2266b",
            "fullname": "fullname",
            "caption": "captioncaptioncaptioncaptioncaption",
            "likes": 4
        ]))
    }
}
