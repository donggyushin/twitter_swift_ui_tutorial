//
//  FilterButtonsView.swift
//  twitter
//
//  Created by 신동규 on 2021/11/18.
//

import SwiftUI

enum TweetFilterOptions: Int, CaseIterable {
    case tweets
    case replies
    case likes
    
    var title: String {
        switch self {
        case .likes: return "Likes"
        case .replies: return  "Tweets & Replies"
        case .tweets: return  "Tweets"
        }
    }
}

struct FilterButtonsView: View {
    private let filterButtonWidth = UIScreen.main.bounds.size.width / CGFloat(TweetFilterOptions.allCases.count)
    
    @Binding var selectedOption: TweetFilterOptions
    
    private var underlinePadding: CGFloat {
        return filterButtonWidth * CGFloat(selectedOption.rawValue)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ForEach(TweetFilterOptions.allCases, id: \.self) {
                    option in
                    Button {
                        self.selectedOption = option
                    } label: {
                        Text(option.title)
                    }
                    .frame(width: filterButtonWidth)

                }
            }
            
            Rectangle()
                .frame(width: filterButtonWidth - 60, height: 3, alignment: .center)
                .foregroundColor(.blue)
                .padding(.leading, underlinePadding + 34)
                .animation(.spring(), value: underlinePadding)
        }
    }
}

struct FilterButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        FilterButtonsView(selectedOption: .constant(.tweets))
    }
}
