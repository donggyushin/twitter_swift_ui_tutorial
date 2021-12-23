//
//  TweetRepository.swift
//  twitter
//
//  Created by 신동규 on 2021/12/16.
//

import RxSwift

protocol TweetRepository {
    func likeTweet(tweet: Tweet) -> Observable<Result<Bool, Error>>
    func unlikeTweet(tweet: Tweet) -> Observable<Result<Bool, Error>>
    func checkIfUserLikedTweet(tweet: Tweet) -> Observable<Result<Bool, Error>>
    func fetchLikedTweets(userId: String) -> Observable<Result<[Tweet], Error>>
    func fetchTweets(userId: String) -> Observable<Result<[Tweet], Error>>
    func fetchTweets() -> Observable<Result<[Tweet], Error>>
    func uploadTweet(caption: String) -> Observable<Result<Bool, Error>>
}
