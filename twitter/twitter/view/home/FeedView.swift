//
//  FeedView.swift
//  twitter
//
//  Created by 신동규 on 2021/11/17.
//

import SwiftUI

struct FeedView: View {
    
    @State var isShowingNewTweetView = false
    @ObservedObject var viewModel = ViewModelDependency.resolve().feedViewModel
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView(.vertical) {
                VStack {
                    ForEach(viewModel.tweets) {tweet in
                        NavigationLink {
                            TweetDetailView(tweet: tweet)
                        } label: {
                            TweetCell(tweet: tweet)
                                .padding(.horizontal)
                                .padding(.bottom)
                        }
                    }
                }
                .padding(.top)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 1)
            
            Button {
                self.isShowingNewTweetView.toggle()
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
            .fullScreenCover(isPresented: $isShowingNewTweetView) {
                NewTweetView(isPresented: $isShowingNewTweetView)
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
