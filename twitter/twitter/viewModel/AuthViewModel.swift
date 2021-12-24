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
import Combine

class AuthViewModel: ObservableObject {
    
    @Published var userSession: User?
    @Published var isAuthenticating = false
    @Published var error: Error?
    @Published var errorToastPresent = false
    @Published var user: TwitterUser?
    @Published var isLoading = false
    
    static let shared = AuthViewModel(userRepository: RepositoryDependency.resolve().userRepository)
    
    let userRepository: UserRepository
    private let disposeBag = DisposeBag()
    private var subscriber = Set<AnyCancellable>()
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
        self.userSession = Auth.auth().currentUser
        fetchUser()
        bind()
    }
    
    private func bind() {
        $error.sink { [weak self] error in
            self?.errorToastPresent = error != nil
        }.store(in: &subscriber)
    }
    
    func signOut() {
        self.userSession = nil
        userRepository.signOut()
    }
    
    func login(email: String, password: String) {
        self.isLoading = true
        userRepository.login(email: email, password: password).subscribe(onNext: {[weak self] result in
            self?.isLoading = false
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
                self?.user = nil 
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
