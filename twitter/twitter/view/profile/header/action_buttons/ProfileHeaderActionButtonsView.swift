//
//  ProfileHeaderActionButtonsView.swift
//  twitter
//
//  Created by 신동규 on 2021/11/18.
//

import SwiftUI

struct ProfileHeaderActionButtonsView: View {
    
    @Binding var isMe: Bool
    
    var body: some View {
        
        if isMe {
            Button {
                
            } label: {
                Text("Edit Profile")
                    .frame(minWidth: 300, idealWidth: 360, minHeight: 40, idealHeight: 40)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .shadow(radius: 5)
            }
        } else {
            HStack(spacing: 20) {
                Button {
                    
                } label: {
                    Text("Following")
                        .frame(minWidth: 150, idealWidth: 180, minHeight: 40, idealHeight: 40)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .shadow(radius: 5)
                }
                
                Button {
                    
                } label: {
                    Text("Message")
                        .frame(minWidth: 150, idealWidth: 180, minHeight: 40, idealHeight: 40)
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
