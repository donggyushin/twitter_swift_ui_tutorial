//
//  CustomError.swift
//  twitter
//
//  Created by 신동규 on 2021/12/16.
//

import Foundation

enum CustomError: Error {
    case testError
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .testError:
            return .init("테스트 에러입니다.")
        }
    }
}


