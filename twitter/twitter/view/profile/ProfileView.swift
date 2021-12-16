//
//  ProfileView.swift
//  twitter
//
//  Created by 신동규 on 2021/11/18.
//

import SwiftUI

struct ProfileView: View {
    
    @State var selectedOption: TweetFilterOptions = .tweets
    @ObservedObject var viewModel: ProfileViewModel
    
    init(user: TwitterUser) {
        self.viewModel = .init(user: user, tweetRepository: RepositoryDependency.resolve().tweetRepository)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ProfileHeaderView(viewModel: viewModel)
                    .padding(.top)
                
                FilterButtonsView(selectedOption: $selectedOption)
                    .padding(.vertical)
                
                ForEach(viewModel.tweets(filter: selectedOption)) { tweet in
                    TweetCell(tweet: tweet)
                        .padding(.horizontal)
                        .padding(.bottom)
                }
            }
            .navigationTitle(viewModel.user.username)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: .init(dictionary: ["email": "test2@gmail.com",
                                             "fullname": "Shin donggyu",
                                             "profileImageUrl": "https://firebasestorage.googleapis.com:443/v0/b/twitter-swift-ui-754b7.appspot.com/o/9CACC08F-0341-4FBD-B7E6-C40BAE58A83B?alt=media&token=3ed1e3aa-41f6-4c89-a750-37ca42d2266b",
                                             "uid": "asd",
                                             "username": "Spider Man"]))
    }
}
