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
}
