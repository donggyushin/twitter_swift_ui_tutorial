//
//  LoginView.swift
//  twitter
//
//  Created by 신동규 on 2021/11/20.
//

import SwiftUI
import UIKit

struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    let screenWidth = UIScreen.main.bounds.width
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Image("twitter-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120)
                       
                    TextFieldView(placeHolder: "Email", image_name: "envelope", text: $email)
                        .padding()
                    
                    PasswordTextFieldView(placeHolder: "Password", text: $password)
                        .padding(.horizontal)
                    
                    HStack {
                        Spacer()
                        Button {
                            
                        } label: {
                            Text("Forgot Password?")
                                .foregroundColor(.white)
                                .font(.footnote)
                        }
                        .padding()
                    }
                    
                    Button {
                        viewModel.login(email: email, password: password)
                    } label: {
                        Text("Sign In")
                            .frame(width: screenWidth - 40, height: 40)
                            .background(.white)
                            .cornerRadius(20)
                    }

                    Spacer()
                    
                    NavigationLink(destination: RegistrationView().navigationBarBackButtonHidden(true)) {
                        Text("Don't have an account?")
                            .foregroundColor(.white)
                    }
                }
                .background(background_color)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
