//
//  UserRepository.swift
//  twitter
//
//  Created by 신동규 on 2021/12/16.
//

import RxSwift
import Firebase
import UIKit

protocol UserRepository {
    func fetchUsers() -> Observable<Result<[TwitterUser], Error>>
    func follow(userId: String) -> Observable<Result<Bool, Error>>
    func unfollow(userId: String) -> Observable<Result<Bool, Error>>
    func fetchStats(id: String) -> Observable<Result<TwitterUser.Stats, Error>>
    func checkIsFollowed(userId: String) -> Observable<Result<Bool, Error>>
    func signOut()
    func login(email: String, password: String) -> Observable<Result<User, Error>>
    func registerUser(email: String, password: String, username: String, fullname: String, profileImage: UIImage) -> Observable<Result<User, Error>>
    func fetchUser() -> Observable<Result<TwitterUser, Error>>
}
