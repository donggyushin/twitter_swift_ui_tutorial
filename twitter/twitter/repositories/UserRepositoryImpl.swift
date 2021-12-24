//
//  UserRepositoryImpl.swift
//  twitter
//
//  Created by 신동규 on 2021/12/16.
//

import RxSwift
import Firebase
import UIKit

class UserRepositoryImpl: UserRepository {
    
    func fetchUser() -> Observable<Result<TwitterUser, Error>> {
        return .create { observer in
            
            guard let uid = Auth.auth().currentUser?.uid else { return Disposables.create()}
            Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
                guard let data = snapshot?.data() else { return }
                observer.onNext(.success(.init(dictionary: data)))
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    func registerUser(email: String, password: String, username: String, fullname: String, profileImage: UIImage) -> Observable<Result<User, Error>> {
        return .create { observer in
            
            guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else { return Disposables.create() }
            
            let filename = NSUUID().uuidString
            let storageRef = Storage.storage().reference().child(filename)
            storageRef.putData(imageData, metadata: nil) { _, error in
                if let error = error {
                    observer.onNext(.failure(error))
                    observer.onCompleted()
                    return
                }
                
                storageRef.downloadURL { url, _ in
                    guard let profileImageUrl = url?.absoluteString else { return }
                    
                    
                    Auth.auth().createUser(withEmail: email, password: password) { result, error in
                        if let error = error {
                            observer.onNext(.failure(error))
                            observer.onCompleted()
                            return
                        }
                        
                        guard let user = result?.user else { return }
                        
                        let data: [String: Any] = [
                            "email": email,
                            "fullname": fullname,
                            "username": username.lowercased(),
                            "profileImageUrl": profileImageUrl,
                            "uid": user.uid
                        ]
                        
                        Firestore.firestore().collection("users").document(user.uid).setData(data) { error in
                            
                            observer.onNext(.success(user))
                            observer.onCompleted()
                        }
                        
                    }
                    
                }
            }
            
            return Disposables.create()
        }
    }
    
    func login(email: String, password: String) -> Observable<Result<User, Error>> {
        return .create { observer in
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let error = error {
                    observer.onNext(.failure(error))
                } else if let user = result?.user {
                    observer.onNext(.success(user))
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    func fetchUsers() -> Observable<Result<[TwitterUser], Error>> {
        return Observable.create { observer in
            COLLECTION_USERS.getDocuments { snapshot, error in
                if let error = error {
                    observer.onNext(.failure(error))
                } else {
                    guard let documents = snapshot?.documents else { return }
                    guard let uid = Auth.auth().currentUser?.uid else { return }
                    let tweets = documents.map({ TwitterUser(dictionary: $0.data()) }).filter({ $0.id != uid })
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
    
    func signOut() {
        try? Auth.auth().signOut()
    }
}
