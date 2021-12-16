//
//  SearchViewModel.swift
//  twitter
//
//  Created by 신동규 on 2021/11/26.
//

import SwiftUI
import Firebase
import RxSwift

class SearchViewModel: ObservableObject {
    @Published var users: [TwitterUser] = []
    
    private let userRepository: UserRepository
    private let disposeBag = DisposeBag()
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
        fetchUsers()
    }
    
    func fetchUsers() {
        userRepository.fetchUsers().subscribe(onNext: {[weak self] result in
            switch result {
            case .failure(let error):
                print("DEBUG: Error: \(error.localizedDescription)")
            case .success(let users):
                self?.users = users
            }
        }).disposed(by: disposeBag)
    }
}
