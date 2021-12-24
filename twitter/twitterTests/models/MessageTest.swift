//
//  MessageTest.swift
//  twitterTests
//
//  Created by 신동규 on 2021/12/24.
//

import XCTest
@testable import twitter

class MessageTest: XCTestCase {
    func testChatPartnerId() {
        let message: Message = .init(user: .init(dictionary: [
            "email": "test2@gmail.com",
            "fullname": "Shin donggyu",
            "profileImageUrl": "https://firebasestorage.googleapis.com:443/v0/b/twitter-swift-ui-754b7.appspot.com/o/9CACC08F-0341-4FBD-B7E6-C40BAE58A83B?alt=media&token=3ed1e3aa-41f6-4c89-a750-37ca42d2266b",
            "uid": "asd",
            "username": "Spider Man"
        ]), dictionary: [
            "text": "asd",
            "toId": "asd",
            "fromId": "fromId",
            "id": "id"
        ])
        
        XCTAssertEqual("fromId", message.chatPartnerId)
    }
    
    func testChatPartnerId2() {
        var message: Message = .init(user: .init(dictionary: [:]), dictionary: [:])
        message.isFromCurrentUser = true
        XCTAssertEqual("", message.chatPartnerId)
    }
}
