//
//  FeedViewModel.swift
//  twitter
//
//  Created by 신동규 on 2021/12/08.
//

import SwiftUI
import Combine

class FeedViewModel: ObservableObject {
    @Published var tweets: [Tweet] = []
    private var disposeBag = Set<AnyCancellable>()
    
    init() {
        fetchTweets()
        bind()
        setTweetsCacheData()
    }
    
    func fetchTweets() {
        COLLECTION_TWEETS.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.tweets = documents.map({ Tweet(dictionary: $0.data()) })
        }
    }
    
    private func bind() {
        $tweets.sink { tweets in
            if tweets.isEmpty == false { tweets.saveUserDefaults() }
        }.store(in: &disposeBag)
    }
    
    private func setTweetsCacheData() {
        self.tweets = Tweet.getTweetArrayFromUserDefaults()
    }
}
