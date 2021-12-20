//
//  SearchViewModelTest.swift
//  twitterTests
//
//  Created by 신동규 on 2021/12/20.
//

import XCTest
import RxSwift
import UIKit
@testable import twitter

class SearchViewModelTest: XCTestCase {
    func testInit() {
        let vm = ViewModelDependency.resolve().searchViewModelTest
        
        let expectation: XCTestExpectation = .init(description: "testInitExpectation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
        XCTAssertEqual(0, vm.users.count)
    }
}
