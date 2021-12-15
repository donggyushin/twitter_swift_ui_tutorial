//
//  FollowingFollwerView.swift
//  twitter
//
//  Created by 신동규 on 2021/11/18.
//

import SwiftUI

struct FollowingFollwerView: View {
    let text: String
    let number: Int
    var body: some View {
        VStack {
            Text("\(number)")
                .font(.system(size: 14, weight: .semibold))
            
            Text(text)
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
}

struct FollowingFollwerView_Previews: PreviewProvider {
    static var previews: some View {
        FollowingFollwerView(text: "Followers", number: 12)
    }
}
