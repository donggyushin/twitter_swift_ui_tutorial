//
//  UserCell.swift
//  twitter
//
//  Created by 신동규 on 2021/11/17.
//

import SwiftUI
import Kingfisher

struct UserCell: View {
    
    let user: TwitterUser
    
    var body: some View {
        HStack(spacing: 18) {
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .frame(width: 56, height: 56)
                .scaledToFill()
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(user.username)
                    .font(.system(size: 13, weight: .semibold))
                
                Text(user.fullname)
                    .font(.system(size: 15, weight: .light))
            }
            .foregroundColor(.primary)
            Spacer()
        }
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell(user: .init(dictionary: ["email": "test2@gmail.com",
                                          "fullname": "Shin donggyu",
                                          "profileImageUrl": "https://firebasestorage.googleapis.com:443/v0/b/twitter-swift-ui-754b7.appspot.com/o/9CACC08F-0341-4FBD-B7E6-C40BAE58A83B?alt=media&token=3ed1e3aa-41f6-4c89-a750-37ca42d2266b",
                                          "uid": "asd",
                                          "username": "Spider Man"]))
    }
}
