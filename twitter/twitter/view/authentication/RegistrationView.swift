//
//  RegistrationView.swift
//  twitter
//
//  Created by 신동규 on 2021/11/20.
//

import SwiftUI

struct RegistrationView: View {
    
    @State var fullName: String = ""
    @State var email: String = ""
    @State var userName: String = ""
    @State var password: String = ""
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            VStack {
                Image("twitter-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120)
                
                TextFieldView(placeHolder: "Full Name", image_name: "person", text: $fullName)
                    .padding(.horizontal)
                
                TextFieldView(placeHolder: "Email", image_name: "envelope", text: $email)
                    .padding(.horizontal)
                
                TextFieldView(placeHolder: "User Name", image_name: "person", text: $userName)
                    .padding(.horizontal)
                
                PasswordTextFieldView(placeHolder: "Password", text: $password)
                    .padding(.horizontal)
                
                Button {
                    
                } label: {
                    Text("Sign Up")
                        .frame(width: screenWidth - 40, height: 40)
                        .background(.white)
                        .cornerRadius(20)
                }
                .padding(.top, 40)
                
                Spacer()
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Already have an account")
                        .foregroundColor(.white)
                }
            }
            
                .background(background_color)
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
