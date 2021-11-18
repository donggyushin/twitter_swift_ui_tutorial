//
//  ProfileHeaderView.swift
//  twitter
//
//  Created by 신동규 on 2021/11/18.
//

import SwiftUI

struct ProfileHeaderView: View {
    
    @State var followers: Int = 12
    @State var followings: Int = 0
    @State var isMe: Bool = false
    
    var body: some View {
        VStack {
            Image("spiderman")
                .resizable()
                .frame(width: 120, height: 120)
                .scaledToFill()
                .clipShape(Circle())
                .shadow(color: .black, radius: 10, x: 0, y: 0)
            
            Text("Tom Holand")
                .font(.system(size: 16, weight: .semibold))
                .padding(.top, 8)
            
            Text("@Spider man")
                .font(.footnote)
                .foregroundColor(.gray)
            
            Text("Hello World! Swift UI is awesome but tricky..!")
                .padding(.top)
                .padding(.horizontal)
            
            HStack(spacing: 40) {
                FollowingFollwerView(text: .constant("Followers"), number: $followers)
                
                FollowingFollwerView(text: .constant("Followings"), number: $followings)
            }
            .padding(.top, 20)
            
            ProfileHeaderActionButtonsView(isMe: $isMe)
                .padding(.top)
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView()
    }
}
