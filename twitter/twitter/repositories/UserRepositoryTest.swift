//
//  UserRepositoryTest.swift
//  twitter
//
//  Created by 신동규 on 2021/12/16.
//

import RxSwift
import Firebase
import UIKit

class UserRepositoryTest: UserRepository {
    func fetchUsers() -> Observable<Result<[TwitterUser], Error>> {
        return .create { observer in
            
            let user: TwitterUser = .init(dictionary: ["username": "asd", "fullname": "asd"])
            
            observer.onNext(.success([user]))
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func follow(userId: String) -> Observable<Result<Bool, Error>> {
        return .create { observer in
            
            observer.onNext(.success(true))
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func unfollow(userId: String) -> Observable<Result<Bool, Error>> {
        return .create { observer in
            
            observer.onNext(.success(false))
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func fetchStats(id: String) -> Observable<Result<TwitterUser.Stats, Error>> {
        return .create { observer in
            
            observer.onNext(.success(.init(followers: 0, following: 0)))
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func checkIsFollowed(userId: String) -> Observable<Result<Bool, Error>> {
        return .create { observer in
            
            observer.onNext(.success(false))
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut()
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
    
    func registerUser(email: String, password: String, username: String, fullname: String, profileImage: UIImage) -> Observable<Result<User, Error>> {
        return .create { observer in
            
            let error: CustomError = .testError
            observer.onNext(.failure(error))
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func fetchUser() -> Observable<Result<TwitterUser, Error>> {
        return .create { observer in
            observer.onNext(.success(.init(dictionary: ["uid": "1"])))
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
