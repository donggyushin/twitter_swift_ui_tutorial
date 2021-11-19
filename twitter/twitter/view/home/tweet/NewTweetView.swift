//
//  NewTweetView.swift
//  twitter
//
//  Created by 신동규 on 2021/11/19.
//

import SwiftUI

struct NewTweetView: View {
    
    @Binding var isShowingNewTweetView: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                HStack() {
                    Image("batman")
                        .resizable()
                        .frame(width: 56, height: 56)
                        .clipShape(Circle())
                        .scaledToFill()
                        .padding(.leading)
                    
                    Text("Hello World!")
                        .foregroundColor(.gray)
                    
                    Spacer()
                }
                
                Spacer()
            }
            
            .navigationBarItems(
                leading: Button(action: {
                    self.isShowingNewTweetView.toggle()
            }, label: {
                Text("Cancel")
            }), trailing: Button(action: {
                
            }, label: {
                Text("Tweet")
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }))
        }
    }
}

struct NewTweetView_Previews: PreviewProvider {
    static var previews: some View {
        NewTweetView(isShowingNewTweetView: .constant(true))
    }
}
