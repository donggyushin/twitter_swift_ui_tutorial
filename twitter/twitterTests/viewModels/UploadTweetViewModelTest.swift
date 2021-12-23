//
//  UploadTweetViewModelTest.swift
//  twitterTests
//
//  Created by 신동규 on 2021/12/23.
//

import XCTest
@testable import twitter
import SwiftUI

class UploadTweetViewModelTest: XCTestCase {
    func testUploadTweet() {
        let feedView: FeedView = .init(viewModel: ViewModelDependency.resolve().feedViewModelTest)
        let viewModel = ViewModelDependency.resolve().uploadTweetViewModelFactoryTest(feedView.$viewModel.isShowingNewTweetView)
        viewModel.uploadTweet(caption: "")
        let expectation: XCTestExpectation = .init(description: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 5)
        XCTAssertFalse(feedView.viewModel.isShowingNewTweetView)
        XCTAssertFalse(viewModel.isPresented)
    }
}
