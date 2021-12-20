//
//  TweetRepositoryTest.swift
//  twitter
//
//  Created by 신동규 on 2021/12/20.
//

import RxSwift

class TweetRepositoryTest: TweetRepository {
    func likeTweet(tweet: Tweet) -> Observable<Result<Bool, Error>> {
        return .create { observer in
            observer.onNext(.success(true))
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func unlikeTweet(tweet: Tweet) -> Observable<Result<Bool, Error>> {
        return .create { observer in
            observer.onNext(.success(false))
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func checkIfUserLikedTweet(tweet: Tweet) -> Observable<Result<Bool, Error>> {
        return .create { observer in
            observer.onNext(.success(tweet.id == "1"))
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func fetchLikedTweets(userId: String) -> Observable<Result<[Tweet], Error>> {
        return .create { observer in
            observer.onNext(.success([]))
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func fetchTweets(userId: String) -> Observable<Result<[Tweet], Error>> {
        return .create { observer in
            observer.onNext(.success([]))
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func fetchTweets() -> Observable<Result<[Tweet], Error>> {
        return .create { observer in
            observer.onNext(.success([]))
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
