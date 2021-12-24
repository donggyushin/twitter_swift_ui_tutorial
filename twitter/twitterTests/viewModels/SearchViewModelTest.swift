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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
        XCTAssertEqual(1, vm.users.count)
    }
    
    func testFilteredUsers() {
        let vm = ViewModelDependency.resolve().searchViewModelTest
        let expectation: XCTestExpectation = .init(description: "testInitExpectation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        vm.searchText = "5"
        
        XCTAssertEqual(vm.filteredUsers().count, 0)
    }
}
