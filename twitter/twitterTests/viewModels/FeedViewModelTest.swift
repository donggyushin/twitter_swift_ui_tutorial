//
//  FeedViewModelTest.swift
//  twitterTests
//
//  Created by 신동규 on 2021/12/22.
//

import RxSwift
import XCTest
@testable import twitter

class FeedViewModelTest: XCTestCase {
    
    let disposeBag = DisposeBag()
    
    func testInit() {
        let viewModel = ViewModelDependency.resolve().feedViewModelTest
        let tweetRepository = RepositoryDependency.resolve().tweetRepositoryTest
        let expectation: XCTestExpectation = .init(description: "Mock Networking")
        tweetRepository.fetchTweets().subscribe(onNext: { _ in
            expectation.fulfill()
        }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(viewModel.tweets.count, 1)
    }
}
