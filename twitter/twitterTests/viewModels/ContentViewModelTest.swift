//
//  ContentViewModelTest.swift
//  twitterTests
//
//  Created by 신동규 on 2021/12/25.
//

import XCTest
@testable import twitter

class ContentViewModelTest: XCTestCase {
    func testSetNavigationTitle() {
        let vm: ContentViewModel = ViewModelDependency.resolve().contentViewModelTestFactory()
        XCTAssertEqual(vm.navigationTitle(), "Home")
        vm.currentTab = 1
        XCTAssertEqual(vm.navigationTitle(), "Search")
        vm.currentTab = 2
        XCTAssertEqual(vm.navigationTitle(), "Message")
    }
}
