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
        let viewModel = ViewModelDependency.resolve().uploadTweetViewModelFactoryTest(.constant(true))
        viewModel.uploadTweet(caption: "")
        let expectation: XCTestExpectation = .init(description: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 5)
        XCTAssertFalse(viewModel.published_isPresented)
    }
}
