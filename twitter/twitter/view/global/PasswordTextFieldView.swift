//
//  PasswordTextFieldView.swift
//  twitter
//
//  Created by 신동규 on 2021/11/20.
//

import SwiftUI

struct PasswordTextFieldView: View {
    
    let placeHolder: String
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeHolder)
                    .padding(.leading, 45)
                    .foregroundColor(.white)
            }
            
            HStack {
                Image(systemName: "lock")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                
                SecureField("", text: $text)
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color(white: 1, opacity: 0.2))
            .cornerRadius(4)
        }
    }
}

struct PasswordTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordTextFieldView(placeHolder: "Password", text: .constant(""))
    }
}
