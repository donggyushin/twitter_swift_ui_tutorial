//
//  AuthViewModelTest.swift
//  twitterTests
//
//  Created by 신동규 on 2021/12/16.
//

import XCTest
import RxSwift
@testable import twitter

class AuthViewModelTest: XCTestCase {
    let viewModel: AuthViewModel = ViewModelDependency.resolve().authViewModelTest
    
    func testSignOut() {
        viewModel.signOut()
        XCTAssertNil(viewModel.userSession)
    }
    
    func testLogin() {
        let expectation = XCTestExpectation(description: "APIPrivoderTaskExpectation")
        viewModel.login(email: "test2@gmail.com", password: "qqqqqq")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
        XCTAssertNotNil(viewModel.userSession)
        XCTAssertEqual(viewModel.user?.id, "1")
    }
    
    
}
