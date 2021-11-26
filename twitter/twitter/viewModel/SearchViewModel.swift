//
//  SearchViewModel.swift
//  twitter
//
//  Created by 신동규 on 2021/11/26.
//

import SwiftUI
import Firebase

class SearchViewModel: ObservableObject {
    @Published var users: [TwitterUser] = []
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        COLLECTION_USERS.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.users = documents.map({ TwitterUser(dictionary: $0.data()) })
        }
    }
}
