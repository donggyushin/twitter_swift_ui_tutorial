//
//  TweetRepositoryImpl.swift
//  twitter
//
//  Created by 신동규 on 2021/12/16.
//

import RxSwift
import Firebase

class TweetRepositoryImpl: TweetRepository {
    
    func uploadTweet(caption: String) -> Observable<Result<Bool, Error>> {
        return .create { observer in
            
            guard let user = AuthViewModel.shared.user else { return Disposables.create() }
            let docRef = COLLECTION_TWEETS.document()
            let data: [String: Any] = [
                "uid": user.id,
                "caption": caption,
                "fullname": user.fullname,
                "timestamp": Timestamp(date: Date()),
                "username": user.username,
                "profileImageUrl": user.profileImageUrl,
                "likes": 0,
                "id": docRef.documentID
            ]
            docRef.setData(data) { _ in
                observer.onNext(.success(false))
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    func fetchTweets() -> Observable<Result<[Tweet], Error>> {
        return .create { observer in
            COLLECTION_TWEETS.getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else {
                    observer.onNext(.success([]))
                    observer.onCompleted()
                    return }

                observer.onNext(.success(documents.map({ Tweet(dictionary: $0.data()) })))
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    func fetchTweets(userId: String) -> Observable<Result<[Tweet], Error>> {
        return .create { observer in
            
            COLLECTION_TWEETS.whereField("uid", isEqualTo: userId).getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else {
                    observer.onNext(.success([]))
                    observer.onCompleted()
                    return
                }
                observer.onNext(.success(documents.map({ Tweet(dictionary: $0.data()) })))
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    func likeTweet(tweet: Tweet) -> Observable<Result<Bool, Error>> {
        return .create { observer in
            
            guard let uid = Auth.auth().currentUser?.uid else {
                observer.onNext(.success(false))
                observer.onCompleted()
                return Disposables.create()
            }
            
            
            let tweetLikesRef = COLLECTION_TWEETS.document(tweet.id).collection("tweet-likes")
            let userLikesRef = COLLECTION_USERS.document(uid).collection("user-likes")
            
            tweetLikesRef.document(uid).setData([:]) { _ in
                COLLECTION_TWEETS.document(tweet.id).updateData(["likes": tweet.likes + 1]) { _ in
                    userLikesRef.document(tweet.id).setData([:]) { _ in
                        observer.onNext(.success(true))
                        observer.onCompleted()
                    }
                }
            }
            
            return Disposables.create()
        }
    }
    
    func unlikeTweet(tweet: Tweet) -> Observable<Result<Bool, Error>> {
        return .create { observer in
            guard let uid = Auth.auth().currentUser?.uid else {
                observer.onNext(.success(true))
                observer.onCompleted()
                return Disposables.create()
            }
            
            let tweetLikesRef = COLLECTION_TWEETS.document(tweet.id).collection("tweet-likes")
            let userLikesRef = COLLECTION_USERS.document(uid).collection("user-likes")
            
            tweetLikesRef.document(uid).delete { _ in
                COLLECTION_TWEETS.document(tweet.id).updateData(["likes": tweet.likes - 1]) { _ in
                    userLikesRef.document(tweet.id).delete { _ in
                        observer.onNext(.success(false))
                        observer.onCompleted()
                    }
                }
            }
            
            return Disposables.create()
        }
    }
    
    func checkIfUserLikedTweet(tweet: Tweet) -> Observable<Result<Bool, Error>> {
        return .create { observer in
            
            guard let uid = Auth.auth().currentUser?.uid else {
                observer.onNext(.success(false))
                observer.onCompleted()
                return Disposables.create() }
            COLLECTION_TWEETS.document(tweet.id).collection("tweet-likes").document(uid).getDocument { snapshot, _ in
                observer.onNext(.success(snapshot?.data() != nil))
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    func fetchLikedTweets(userId: String) -> Observable<Result<[Tweet], Error>> {
        return .create { observer in
            
            var tweets: [Tweet] = []
            COLLECTION_USERS.document(userId).collection("user-likes").getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else {
                    observer.onNext(.success(tweets))
                    observer.onCompleted()
                    return }
                let tweetIds = documents.map({ $0.documentID })
                tweetIds.forEach({
                    COLLECTION_TWEETS.document($0).getDocument { snapshot, _ in
                        guard let data = snapshot?.data() else { return }
                        tweets.append(.init(dictionary: data))
                        if tweets.count == tweetIds.count {
                            observer.onNext(.success(tweets))
                            observer.onCompleted()
                        }
                    }
                })
            }
            
            return Disposables.create()
        }
    }
}
