//
//  UserCell.swift
//  twitter
//
//  Created by 신동규 on 2021/11/17.
//

import SwiftUI

struct UserCell: View {
    var body: some View {
        HStack(spacing: 18) {
            Image("batman")
                .resizable()
                .frame(width: 56, height: 56)
                .scaledToFill()
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text("Batman")
                    .font(.system(size: 13, weight: .semibold))
                
                Text("Bruce Wayne")
                    .font(.system(size: 15, weight: .light))
            }
            .foregroundColor(.black)
            Spacer()
        }
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell()
    }
}
