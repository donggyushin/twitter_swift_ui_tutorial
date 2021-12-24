//
//  ProfileHeaderActionButtonsView.swift
//  twitter
//
//  Created by 신동규 on 2021/11/18.
//

import SwiftUI
import LazyViewSwiftUI

struct ProfileHeaderActionButtonsView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    private let screenWidth = UIScreen.main.bounds.size.width
    
    var body: some View {
        
        if viewModel.user.isMe {
            Button {
                
            } label: {
                Text("Edit Profile")
                    .frame(width: screenWidth - 60, height: 40)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .shadow(radius: 5)
            }
        } else {
            HStack(spacing: 10) {
                Button {
                    viewModel.user.isFollowed ? viewModel.unfollow() : viewModel.follow()
                } label: {
                    Text(viewModel.user.isFollowed ? "Following" : "Follow")
                        .frame(width: (screenWidth - 60) / 2, height: 40)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .shadow(radius: 5)
                }
                
                NavigationLink {
                    LazyView(ChatView(user: viewModel.user))
                } label: {
                    Text("Message")
                        .frame(width: (screenWidth - 60) / 2, height: 40)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .shadow(radius: 5)
                }
            }
            
        }
        
    }
}

struct ProfileHeaderActionButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderActionButtonsView(viewModel: .init(user: .init(dictionary: ["email": "test2@gmail.com",
                                                                                 "fullname": "Shin donggyu",
                                                                                 "profileImageUrl": "https://firebasestorage.googleapis.com:443/v0/b/twitter-swift-ui-754b7.appspot.com/o/9CACC08F-0341-4FBD-B7E6-C40BAE58A83B?alt=media&token=3ed1e3aa-41f6-4c89-a750-37ca42d2266b",
                                                                                 "uid": "asd",
                                                                                 "username": "Spider Man"]), tweetRepository: RepositoryDependency.resolve().tweetRepository, userRepository: RepositoryDependency.resolve().userRepository))
    }
}
