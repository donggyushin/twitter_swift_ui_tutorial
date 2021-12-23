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
    @Published var published_isPresented = true
    var subscriber: Set<AnyCancellable> = .init()
    
    init(isPresented: Binding<Bool>, tweetRepository: TweetRepository) {
        self._isPresented = isPresented
        self.tweetRepository = tweetRepository
        bind()
    }
    
    private func bind() {
        $published_isPresented.filter({ !$0 }).sink { [weak self] isPresented in
            self?.isPresented = isPresented
        }.store(in: &subscriber)
    }
    
    func uploadTweet(caption: String) {
        tweetRepository.uploadTweet(caption: caption).subscribe(onNext: { [weak self] result in
            switch result {
            case .success(let isPresented):
                self?.published_isPresented = isPresented
            case .failure(let error):
                print("DEBUG: \(error.localizedDescription)")
            }
        }).disposed(by: disposeBag)
    }
}
