//
//  FeedViewModel.swift
//  twitter
//
//  Created by 신동규 on 2021/12/08.
//

import SwiftUI
import Combine
import RxSwift

class FeedViewModel: ObservableObject {
    @Published var tweets: [Tweet] = []
    @Published var isShowingNewTweetView = false
    private var subscriber = Set<AnyCancellable>()
    private let disposeBag = DisposeBag()
    
    private let tweetRepository: TweetRepository
    
    init(tweetRepository: TweetRepository) {
        self.tweetRepository = tweetRepository
        setTweetsCacheData()
        fetchTweets()
        bind()
    }
    
    func fetchTweets() {
        tweetRepository.fetchTweets().subscribe(onNext: { [weak self] result in
            switch result {
            case .success(let tweets):
                self?.tweets = tweets
            case .failure(let error):
                print("DEBUG: error: \(error.localizedDescription)")
            }
        }).disposed(by: disposeBag)
    }
    
    private func bind() {
        $tweets.sink { tweets in
            if tweets.isEmpty == false { tweets.saveUserDefaults() }
        }.store(in: &subscriber)
    }
    
    private func setTweetsCacheData() {
        self.tweets = Tweet.getTweetArrayFromUserDefaults()
    }
}
