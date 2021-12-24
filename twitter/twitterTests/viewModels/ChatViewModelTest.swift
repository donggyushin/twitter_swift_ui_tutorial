//
//  ChatViewModelTest.swift
//  twitterTests
//
//  Created by 신동규 on 2021/12/24.
//

import XCTest
@testable import twitter

class ChatViewModelTest: XCTestCase {
    let viewModel: ChatViewModel = ViewModelDependency.resolve().chatViewModelFactoryTest(.init(dictionary: [
        "uid": "asd",
        "email": "test2@gmail.com",
        "fullname": "shin donggyu",
        "username": "batman",
        "profileImageUrl": "https://firebasestorage.googleapis.com:443/v0/b/twitter-swift-ui-754b7.appspot.com/o/9CACC08F-0341-4FBD-B7E6-C40BAE58A83B?alt=media&token=3ed1e3aa-41f6-4c89-a750-37ca42d2266b"
    ]))
    
    func testSendMessages() {
        viewModel.messageText = "asd"
        viewModel.sendMessages()
    }
    
}
