//
//  TweetActionViewModelTest.swift
//  twitterTests
//
//  Created by 신동규 on 2021/12/21.
//

import XCTest
@testable import twitter

class TweetActionViewModelTest: XCTestCase {
    let tweet: Tweet = .init(dictionary: [
        "uid": "asd",
        "username": "username",
        "profileImageUrl": "https://firebasestorage.googleapis.com:443/v0/b/twitter-swift-ui-754b7.appspot.com/o/9CACC08F-0341-4FBD-B7E6-C40BAE58A83B?alt=media&token=3ed1e3aa-41f6-4c89-a750-37ca42d2266b",
        "fullname": "fullname",
        "caption": "captioncaptioncaptioncaptioncaption",
        "likes": 4
    ])
    lazy var viewModel = ViewModelDependency.resolve().tweetActionViewModelFactoryTest(tweet)
    
    func testInit() {
        let expectation: XCTestExpectation = .init(description: "testInit")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        XCTAssertFalse(viewModel.didLike)
    }
    
    func testLikeTweet() {
        viewModel.likeTweet()
        
        let expectation: XCTestExpectation = .init(description: "test")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        
        XCTAssertTrue(viewModel.didLike)
    }
    
    func testUnlikeTweet() {
        viewModel.unlikeTweet()
        
        let expectation: XCTestExpectation = .init(description: "test")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        XCTAssertFalse(viewModel.didLike)
    }
}
