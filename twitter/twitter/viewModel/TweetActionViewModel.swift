//
//  TweetActionViewModel.swift
//  twitter
//
//  Created by 신동규 on 2021/12/10.
//

import SwiftUI
import Firebase
import RxSwift

class TweetActionViewModel: ObservableObject {
    let tweet: Tweet
    @Published var didLike = false
    
    private let tweetRepository: TweetRepository
    private let disposeBag = DisposeBag()
    
    init(tweet: Tweet, tweetRepository: TweetRepository) {
        self.tweet = tweet
        self.tweetRepository = tweetRepository
        checkIfUserLikedTweet()
    }
    
    func likeTweet() {
        tweetRepository.likeTweet(tweet: tweet).subscribe(onNext: {[weak self] result in
            switch result {
            case .success(let bool):
                self?.didLike = bool
            case .failure(let error):
                print("DEBUG: error: \(error.localizedDescription)")
            }
        }).disposed(by: disposeBag)
    }
    
    func unlikeTweet() {
        tweetRepository.unlikeTweet(tweet: tweet).subscribe(onNext: { [weak self] result in
            switch result {
            case .failure(let error):
                print("DEBUG: error: \(error.localizedDescription)")
            case .success(let bool):
                self?.didLike = bool
            }
        }).disposed(by: disposeBag)
    }
    
    private func checkIfUserLikedTweet() {
        tweetRepository.checkIfUserLikedTweet(tweet: tweet).subscribe(onNext: {[weak self] result in
            switch result {
            case .failure(let error):
                print("DEBUG: error: \(error.localizedDescription)")
            case .success(let bool):
                self?.didLike = bool
            }
        }).disposed(by: disposeBag)
    }
}
