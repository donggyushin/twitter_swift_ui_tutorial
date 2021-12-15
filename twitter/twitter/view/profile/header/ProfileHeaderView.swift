//
//  ProfileHeaderView.swift
//  twitter
//
//  Created by 신동규 on 2021/11/18.
//

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack {
            KFImage(.init(string: viewModel.user.profileImageUrl))
                .resizable()
                .frame(width: 120, height: 120)
                .scaledToFill()
                .clipShape(Circle())
                .shadow(color: .black, radius: 10, x: 0, y: 0)
            
            Text(viewModel.user.fullname)
                .font(.system(size: 16, weight: .semibold))
                .padding(.top, 8)
            
            Text("@\(viewModel.user.username)")
                .font(.footnote)
                .foregroundColor(.gray)
            
            Text("Hello World! Swift UI is awesome but tricky..!")
                .padding(.top)
                .padding(.horizontal)
            
            HStack(spacing: 40) {
                FollowingFollwerView(text: "Followers", number: viewModel.user.stats.followers)
                
                FollowingFollwerView(text: "Followings", number: viewModel.user.stats.following)
            }
            .padding(.top, 20)
            
            ProfileHeaderActionButtonsView(viewModel: viewModel)
                .padding(.top)
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(viewModel: .init(user: .init(dictionary: ["email": "test2@gmail.com",
                                                                    "fullname": "Shin donggyu",
                                                                    "profileImageUrl": "https://firebasestorage.googleapis.com:443/v0/b/twitter-swift-ui-754b7.appspot.com/o/9CACC08F-0341-4FBD-B7E6-C40BAE58A83B?alt=media&token=3ed1e3aa-41f6-4c89-a750-37ca42d2266b",
                                                                    "uid": "asd",
                                                                    "username": "Spider Man"])))
    }
}
