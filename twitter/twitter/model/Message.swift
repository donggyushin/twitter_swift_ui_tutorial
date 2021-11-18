//
//  Message.swift
//  twitter
//
//  Created by 신동규 on 2021/11/18.
//

struct MockMessage: Identifiable {
    let id: Int
    let imageName: String
    let message: String
    let isFromCurrentUser: Bool
}

let MOCK_MESSAGES_DATA: [MockMessage] = [
    .init(id: 0, imageName: "spiderman", message: "Hey What's up", isFromCurrentUser: false),
    .init(id: 1, imageName: "batman", message: "Hi", isFromCurrentUser: true)
]
