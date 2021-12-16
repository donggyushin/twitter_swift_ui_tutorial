//
//  UserRepositoryImpl.swift
//  twitter
//
//  Created by 신동규 on 2021/12/16.
//

import RxSwift

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
}
