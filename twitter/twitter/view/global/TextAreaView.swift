//
//  TextAreaView.swift
//  twitter
//
//  Created by 신동규 on 2021/11/19.
//

import SwiftUI

struct TextAreaView: View {
    let placeHolder: String
    @Binding var text: String
    
    init(placeHolder: String, text: Binding<String>) {
        UITextView.appearance().backgroundColor = .clear
        self.placeHolder = placeHolder
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeHolder)
                    .padding(.leading, 20)
                    .padding(.top, 23)
                    .foregroundColor(.gray)
            }
            TextEditor(text: $text)
                .padding()
        }
    }
}

struct TextAreaView_Previews: PreviewProvider {
    static var previews: some View {
        TextAreaView(placeHolder: "What's happening?", text: .constant(""))
    }
}
