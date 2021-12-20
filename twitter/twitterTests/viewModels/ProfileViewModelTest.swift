//
//  ProfileViewModelTest.swift
//  twitterTests
//
//  Created by 신동규 on 2021/12/20.
//

import XCTest
import RxSwift
import UIKit
@testable import twitter

class ProfileViewModelTest: XCTestCase {
    
    let user: TwitterUser = .init(dictionary: [:])
    
    func testInit() {
        let profileViewModel = ViewModelDependency.resolve().profileViewModelFactoryTest(user)
        let expectation: XCTestExpectation = .init(description: "testFollow")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        
        XCTAssertFalse(profileViewModel.user.isFollowed)
        XCTAssertEqual(profileViewModel.user.stats.followers, 0)
        XCTAssertEqual(profileViewModel.user.stats.following, 0)
        XCTAssertEqual(profileViewModel.likedTweets.count, 0)
        XCTAssertEqual(profileViewModel.userTweets.count, 0)
        
        
        XCTAssertEqual(profileViewModel.tweets(filter: .likes).count, 0)
        XCTAssertEqual(profileViewModel.tweets(filter: .replies).count, 0)
        XCTAssertEqual(profileViewModel.tweets(filter: .tweets).count, 0)
    }
    
    func testFollow() {
        let profileViewModel = ViewModelDependency.resolve().profileViewModelFactoryTest(user)
        profileViewModel.follow()
        let expectation: XCTestExpectation = .init(description: "testFollow")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        XCTAssertTrue(profileViewModel.user.isFollowed)
    }
    
    func testUnFollow() {
        let profileViewModel = ViewModelDependency.resolve().profileViewModelFactoryTest(user)
        profileViewModel.unfollow()
        let expectation: XCTestExpectation = .init(description: "testFollow")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        XCTAssertFalse(profileViewModel.user.isFollowed)
    }
}
