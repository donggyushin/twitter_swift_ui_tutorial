//
//  TweetCell.swift
//  twitter
//
//  Created by 신동규 on 2021/11/17.
//

import SwiftUI

struct TweetCell: View {
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Image("batman")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 56, height: 56)
                    .clipShape(Circle())
                    
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("Bruce Wayne")
                            .font(Font.system(size: 14, weight: .semibold))
                        
                        Text("@batman • 2w")
                            .foregroundColor(.gray)
                        
                    }
                    
                    Text("It's not who I am underneath, but what I do that defines me")
                }
            }
            
            HStack {
                Button {
                    print("nothing")
                } label: {
                    Image(systemName: "bubble.left")
                }
                Spacer()
                Button {
                    print("nothing")
                } label: {
                    Image(systemName: "arrow.2.squarepath")
                }
                Spacer()
                Button {
                    print("nothing")
                } label: {
                    Image(systemName: "heart")
                }
                Spacer()
                Button {
                    print("nothing")
                } label: {
                    Image(systemName: "bookmark")
                }
            }
            .padding(.top, 10)
            .foregroundColor(.gray)
            .padding(.horizontal)
        }
    }
}

struct TweetCell_Previews: PreviewProvider {
    static var previews: some View {
        TweetCell()
    }
}
