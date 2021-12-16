//
//  UserRepository.swift
//  twitter
//
//  Created by 신동규 on 2021/12/16.
//

import RxSwift

protocol UserRepository {
    func fetchUsers() -> Observable<Result<[TwitterUser], Error>>
}
