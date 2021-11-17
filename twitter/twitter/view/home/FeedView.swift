//
//  FeedView.swift
//  twitter
//
//  Created by 신동규 on 2021/11/17.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                VStack {
                    ForEach(0..<100) {_ in
                        TweetCell()
                            .padding(.horizontal)
                            .padding(.bottom)
                    }
                }
            }
            Button {
                print("nothing")
            } label: {
                Image("tweet")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 32, height: 32)
                    .padding()
            }
            .background(Color(.systemBlue))
            .foregroundColor(Color.white)
            .clipShape(Circle())
            .padding()

        }
        
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
