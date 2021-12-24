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
    
    enum Configuration {
        case INCLUDE_ME
        case EXCLUDE_ME
    }
    
    @Published var users: [TwitterUser] = []
    @Published var searchText: String = ""
    
    private let userRepository: UserRepository
    private let disposeBag = DisposeBag()
    private let configuration: Configuration
    
    init(userRepository: UserRepository, configuration: Configuration) {
        self.userRepository = userRepository
        self.configuration = configuration
        fetchUsers()
    }
    
    func fetchUsers() {
        userRepository.fetchUsers().subscribe(onNext: {[weak self] result in
            switch result {
            case .failure(let error):
                print("DEBUG: Error: \(error.localizedDescription)")
            case .success(let users):
                let uid = Auth.auth().currentUser?.uid ?? ""
                switch self?.configuration {
                case .EXCLUDE_ME:
                    self?.users = users.filter({ $0.id != uid })
                case .INCLUDE_ME:
                    self?.users = users
                case .none:
                    self?.users = users
                }
                
            }
        }).disposed(by: disposeBag)
    }
    
    func filteredUsers() -> [TwitterUser] {
        let lowerCasesedQuery = searchText.lowercased()
        return lowerCasesedQuery.isEmpty ? users : users.filter({ $0.fullname.lowercased().contains(lowerCasesedQuery) || $0.username.lowercased().contains(lowerCasesedQuery) })
    }
}
