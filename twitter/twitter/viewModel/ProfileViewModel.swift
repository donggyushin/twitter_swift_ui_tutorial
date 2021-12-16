//
//  ProfileViewModel.swift
//  twitter
//
//  Created by 신동규 on 2021/11/30.
//

import SwiftUI
import Firebase
import RxSwift

class ProfileViewModel: ObservableObject {
    @Published var userTweets: [Tweet] = []
    @Published var likedTweets: [Tweet] = []
    @Published var user: TwitterUser
    
    private let tweetRepository: TweetRepository
    private let userRepository: UserRepository
    
    private let disposeBag = DisposeBag()
    
    init(user: TwitterUser, tweetRepository: TweetRepository, userRepository: UserRepository) {
        self.user = user
        self.tweetRepository = tweetRepository
        self.userRepository = userRepository
        checkIfUserIsFollowed()
        fetchUserTweets()
        fetchLikedTweets()
        updateUserStats()
    }
    
    func follow() {
        userRepository.follow(userId: user.id).subscribe(onNext: { [weak self] result in
            switch result {
            case .success(let bool):
                self?.user.isFollowed = bool
            case .failure(let error):
                print("DEBUG: error: \(error.localizedDescription)")
            }
        }).disposed(by: disposeBag)
    }
    
    func unfollow() {
        userRepository.unfollow(userId: user.id).subscribe(onNext: { [weak self] result in
            switch result {
            case .success(let bool):
                self?.user.isFollowed = bool
            case .failure(let error):
                print("DEBUG: error: \(error.localizedDescription)")
            }
        }).disposed(by: disposeBag)
    }
    
    func tweets(filter: TweetFilterOptions) -> [Tweet] {
        switch filter {
        case .tweets: return self.userTweets
        case .likes: return self.likedTweets
        case .replies: return []
        }
    }
    
    private func updateUserStats() {
        userRepository.fetchStats(id: user.id).subscribe(onNext: {[weak self] result in
            switch result {
            case .success(let stats):
                self?.user.stats = stats
            case .failure(let error):
                print("DEBUG: error: \(error.localizedDescription)")
            }
        }).disposed(by: disposeBag)
    }
    
    private func checkIfUserIsFollowed() {
        
        userRepository.checkIsFollowed(userId: user.id).subscribe(onNext: { [weak self] result in
            switch result {
            case .success(let bool):
                self?.user.isFollowed = bool
            case .failure(let error):
                print("DEBUG: error: \(error.localizedDescription)")
            }
        }).disposed(by: disposeBag)
    }
    
    private func fetchUserTweets() {
        tweetRepository.fetchTweets(userId: user.id).subscribe(onNext: { [weak self] result in
            switch result {
            case .success(let tweets):
                self?.userTweets = tweets
            case .failure(let error):
                print("DEBUG: error: \(error.localizedDescription)")
            }
        }).disposed(by: disposeBag)
    }
    
    private func fetchLikedTweets() {
        tweetRepository.fetchLikedTweets(userId: user.id).subscribe(onNext: {[weak self] result in
            switch result {
            case .failure(let error):
                print("DEBUG: error: \(error.localizedDescription)")
            case .success(let tweets):
                self?.likedTweets = tweets
            }
        }).disposed(by: disposeBag)
    }
}
