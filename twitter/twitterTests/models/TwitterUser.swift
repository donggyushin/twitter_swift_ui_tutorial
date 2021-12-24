//
//  TwitterUser.swift
//  twitterTests
//
//  Created by 신동규 on 2021/12/24.
//

import XCTest
@testable import twitter

class twitterTests: XCTestCase {
    let user: TwitterUser = .init(dictionary: [:])
    
    func testIsMe() {
        XCTAssertFalse(user.isMe)
    }
}

