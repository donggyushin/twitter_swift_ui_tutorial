//
//  ToastErrorView.swift
//  twitter
//
//  Created by 신동규 on 2021/12/25.
//

import SwiftUI

struct ToastErrorView: View {
    let message: String
    var body: some View {
        Text(message)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .padding(.bottom, 50)
            .background(.pink)
    }
}

struct ToastErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ToastErrorView(message: "로그인에 실패하였습니다.")
    }
}
