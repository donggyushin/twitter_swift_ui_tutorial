//
//  AuthViewModel.swift
//  twitter
//
//  Created by 신동규 on 2021/11/23.
//

import SwiftUI
import UIKit
import Firebase
import RxSwift

class AuthViewModel: ObservableObject {
    
    @Published var userSession: User?
    @Published var isAuthenticating = false
    @Published var error: Error?
    @Published var user: TwitterUser?
    
    static let shared = AuthViewModel(userRepository: RepositoryDependency.resolve().userRepository)
    
    private let userRepository: UserRepository
    private let disposeBag = DisposeBag()
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
        self.userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func signOut() {
        self.userSession = nil
        userRepository.signOut()
    }
    
    func login(email: String, password: String) {
        userRepository.login(email: email, password: password).subscribe(onNext: {[weak self] result in
            switch result {
            case .failure(let error):
                self?.error = error
            case .success(let user):
                self?.userSession = user
                self?.user = nil
                self?.fetchUser()
            }
        }).disposed(by: disposeBag)
    }
    
    func registerUser(email: String, password: String, username: String, fullname: String, profileImage: UIImage) {
        
        userRepository.registerUser(email: email, password: password, username: username, fullname: fullname, profileImage: profileImage).subscribe(onNext: { [weak self] result in
            switch result {
            case .success(let user):
                self?.userSession = user
                self?.fetchUser()
            case .failure(let error):
                self?.error = error
            }
        }).disposed(by: disposeBag)
        
    }
    
    func fetchUser() {
        userRepository.fetchUser().subscribe(onNext: { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
            case .failure(let error):
                self?.error = error
            }
        }).disposed(by: disposeBag)
    }
}
