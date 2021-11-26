//
//  TextFieldView.swift
//  twitter
//
//  Created by 신동규 on 2021/11/20.
//

import SwiftUI

struct TextFieldView: View {
    
    let placeHolder: String
    let image_name: String
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeHolder)
                    .padding(.leading, 45)
                    .foregroundColor(.white)
            }
            
            HStack {
                Image(systemName: image_name)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                
                TextField("", text: $text)
                    .foregroundColor(.white)
                    .textInputAutocapitalization(.never)
            }
            .padding()
            .background(Color(white: 1, opacity: 0.2))
            .cornerRadius(4)
        }
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(placeHolder: "Email", image_name: "envelope", text: .constant(""))
    }
}
