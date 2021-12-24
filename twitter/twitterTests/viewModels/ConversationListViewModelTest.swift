//
//  ConversationListViewModelTest.swift
//  twitterTests
//
//  Created by 신동규 on 2021/12/24.
//

import XCTest
@testable import twitter
import SwiftUI

class ConversationListViewModelTest: XCTestCase {
    let viewModel: ConversationListViewModel = ViewModelDependency.resolve().conversationListViewModelTestFactory()
    
    func testInit() {
        
        let expectation: XCTestExpectation = .init(description: "Mock Networking Expectation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        
        XCTAssertEqual(viewModel.recentMessages.count, 1)
    }
    
    func testViewAppear() {
        viewModel.fetchRecentMessages()
        let expectation: XCTestExpectation = .init(description: "Mock Networking Expectation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(viewModel.recentMessages.count, 1)
    }
}
