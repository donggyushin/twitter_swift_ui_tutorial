//
//  UserRepositoryImpl.swift
//  twitter
//
//  Created by 신동규 on 2021/12/16.
//

import RxSwift
import Firebase

class UserRepositoryImpl: UserRepository {
    func fetchUsers() -> Observable<Result<[TwitterUser], Error>> {
        return Observable.create { observer in
            COLLECTION_USERS.getDocuments { snapshot, error in
                if let error = error {
                    observer.onNext(.failure(error))
                } else {
                    guard let documents = snapshot?.documents else { return }
                    let tweets = documents.map({ TwitterUser(dictionary: $0.data()) })
                    observer.onNext(.success(tweets))
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    func follow(userId: String) -> Observable<Result<Bool, Error>> {
        return .create { observer in
            
            guard let currentUid = Auth.auth().currentUser?.uid else {
                observer.onNext(.success(false))
                observer.onCompleted()
                return Disposables.create() }
            
            let followingRef = COLLECTION_FOLLOWING.document(currentUid).collection("user-following")
            let follwersRef = COLLECTION_FOLLOWERS.document(userId).collection("user-followers")
            
            followingRef.document(userId).setData([:]) { _ in
                follwersRef.document(currentUid).setData([:]) { _ in
                    observer.onNext(.success(true))
                    observer.onCompleted()
                }
            }
            
            return Disposables.create()
        }
    }
    
    func unfollow(userId: String) -> Observable<Result<Bool, Error>> {
        return .create { observer in
            
            guard let currentUid = Auth.auth().currentUser?.uid else {
                observer.onNext(.success(true))
                observer.onCompleted()
                return Disposables.create() }
            
            let followingRef = COLLECTION_FOLLOWING.document(currentUid).collection("user-following")
            let follwersRef = COLLECTION_FOLLOWERS.document(userId).collection("user-followers")
            
            followingRef.document(userId).delete { _ in
                follwersRef.document(currentUid).delete { _ in
                    observer.onNext(.success(false))
                    observer.onCompleted()
                }
            }
            
            return Disposables.create()
        }
    }
    
    func fetchStats(id: String) -> Observable<Result<TwitterUser.Stats, Error>> {
        return .create { observer in
            
            let followingRef = COLLECTION_FOLLOWING.document(id).collection("user-following")
            let followersRef = COLLECTION_FOLLOWERS.document(id).collection("user-followers")
            
            followersRef.getDocuments { snapshot, _ in
                let followers = snapshot?.count ?? 0
                followingRef.getDocuments { snapshot, _ in
                    let following = snapshot?.count ?? 0
                    observer.onNext(.success(.init(followers: followers, following: following)))
                    observer.onCompleted()
                }
            }
            
            return Disposables.create()
        }
    }
    
    func checkIsFollowed(userId: String) -> Observable<Result<Bool, Error>> {
        return .create { observer in
            
            guard let currentUid = Auth.auth().currentUser?.uid else {
                observer.onNext(.success(false))
                observer.onCompleted()
                return Disposables.create() }
            
            let followingRef = COLLECTION_FOLLOWING.document(currentUid).collection("user-following")
            followingRef.document(userId).getDocument { snapshot, _ in
                observer.onNext(.success(snapshot?.exists ?? false))
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
}
