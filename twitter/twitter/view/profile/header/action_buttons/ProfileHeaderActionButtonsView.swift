//
//  ProfileHeaderActionButtonsView.swift
//  twitter
//
//  Created by 신동규 on 2021/11/18.
//

import SwiftUI

struct ProfileHeaderActionButtonsView: View {
    
    @Binding var isMe: Bool
    private let screenWidth = UIScreen.main.bounds.size.width
    
    var body: some View {
        
        if isMe {
            Button {
                
            } label: {
                Text("Edit Profile")
                    .frame(width: screenWidth - 60, height: 40)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .shadow(radius: 5)
            }
        } else {
            HStack(spacing: 10) {
                Button {
                    
                } label: {
                    Text("Following")
                        .frame(width: (screenWidth - 60) / 2, height: 40)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .shadow(radius: 5)
                }
                
                Button {
                    
                } label: {
                    Text("Message")
                        .frame(width: (screenWidth - 60) / 2, height: 40)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .shadow(radius: 5)
                }
            }
            
        }
        
    }
}

struct ProfileHeaderActionButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderActionButtonsView(isMe: .constant(false))
    }
}
