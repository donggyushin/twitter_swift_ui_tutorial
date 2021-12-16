//
//  twitterTests.swift
//  twitterTests
//
//  Created by 신동규 on 2021/11/17.
//

import XCTest
import RxSwift
@testable import twitter

class twitterTests: XCTestCase {
    
    let authViewModel = AuthViewModel.shared
    let disposeBag = DisposeBag()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let expectation = XCTestExpectation(description: "APIPrivoderTaskExpectation")

        authViewModel.userSession = nil
        authViewModel.login(email: "test2@gmail.com", password: "qqqqqq")
        authViewModel.userRepository.login(email: "test2@gmail.com", password: "qqqqqq").subscribe(onNext: { _ in
            expectation.fulfill()
        }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(authViewModel.userSession)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
