//
//  ConversationCell.swift
//  twitter
//
//  Created by 신동규 on 2021/11/17.
//

import SwiftUI

struct ConversationCell: View {
    var body: some View {
        HStack(alignment: .top) {
            Image("batman")
                .resizable()
                .frame(width: 56, height: 56)
                .scaledToFill()
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text("Batman")
                    .font(.system(size: 14, weight: .semibold))
                
                Text("Long text to see what happens when I do this. Long text to see what happens")
                    .font(.system(size: 14))
            }
            .foregroundColor(.black)
            .multilineTextAlignment(.leading)
            
            Spacer()
        }
    }
}

struct ConversationCell_Previews: PreviewProvider {
    static var previews: some View {
        ConversationCell()
    }
}
