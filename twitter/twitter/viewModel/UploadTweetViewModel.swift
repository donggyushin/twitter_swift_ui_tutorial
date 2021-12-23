//
//  UploadTweetViewModel.swift
//  twitter
//
//  Created by 신동규 on 2021/12/06.
//

import SwiftUI
import Firebase
import RxSwift
import Combine

class UploadTweetViewModel: ObservableObject {
    
    @Binding var isPresented: Bool
    private let tweetRepository: TweetRepository
    private let disposeBag = DisposeBag()
    var subscriber: Set<AnyCancellable> = .init()
    
    init(isPresented: Binding<Bool>, tweetRepository: TweetRepository) {
        self._isPresented = isPresented
        self.tweetRepository = tweetRepository
    }
    
    func uploadTweet(caption: String) {
        tweetRepository.uploadTweet(caption: caption).subscribe(onNext: { [weak self] result in
            switch result {
            case .success(let isPresented):
                self?.isPresented = isPresented
            case .failure(let error):
                print("DEBUG: \(error.localizedDescription)")
            }
        }).disposed(by: disposeBag)
    }
}
