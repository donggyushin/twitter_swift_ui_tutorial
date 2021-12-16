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
    
    private let disposeBag = DisposeBag()
    
    init(user: TwitterUser, tweetRepository: TweetRepository) {
        self.user = user
        self.tweetRepository = tweetRepository
        checkIfUserIsFollowed()
        fetchUserTweets()
        fetchLikedTweets()
        updateUserStats()
    }
    
    func follow() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let followingRef = COLLECTION_FOLLOWING.document(currentUid).collection("user-following")
        let follwersRef = COLLECTION_FOLLOWERS.document(user.id).collection("user-followers")
        followingRef.document(user.id).setData([:]) { _ in
            follwersRef.document(currentUid).setData([:]) { _ in
                self.user.isFollowed = true
            }
        }
    }
    
    func unfollow() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let followingRef = COLLECTION_FOLLOWING.document(currentUid).collection("user-following")
        let follwersRef = COLLECTION_FOLLOWERS.document(user.id).collection("user-followers")
        followingRef.document(user.id).delete { _ in
            follwersRef.document(currentUid).delete { _ in
                self.user.isFollowed = false
            }
        }
    }
    
    func tweets(filter: TweetFilterOptions) -> [Tweet] {
        switch filter {
        case .tweets: return self.userTweets
        case .likes: return self.likedTweets
        case .replies: return []
        }
    }
    
    private func updateUserStats() {
        user.fetchStats { stats in
            self.user.stats = stats
        }
    }
    
    private func checkIfUserIsFollowed() {
        self.user.checkIsFollowed { isFollowed in
            self.user.isFollowed = isFollowed
        }
    }
    
    private func fetchUserTweets() {
        user.fetchTweets { tweets in
            self.userTweets = tweets
        }
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
