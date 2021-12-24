//
//  RegistrationView.swift
//  twitter
//
//  Created by 신동규 on 2021/11/20.
//

import SwiftUI
import ActivityIndicatorView
import SSToastMessage

struct RegistrationView: View {
    
    @State var selectedUiImage: UIImage? = nil
    @State var selectedImage: Image? = nil
    @State var fullName: String = ""
    @State var email: String = ""
    @State var userName: String = ""
    @State var password: String = ""
    @State var showImagePicker = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var viewModel: AuthViewModel
    
    let screenWidth = UIScreen.main.bounds.width
    
    func configImage() {
        guard let selectedUiImage = selectedUiImage else { return }
        selectedImage = .init(uiImage: selectedUiImage)
    }
    
    var body: some View {
        ZStack {
            VStack {
                Button {
                    showImagePicker.toggle()
                } label: {
                    if let selectedImage = self.selectedImage {
                        selectedImage
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 120)
                            .padding(.bottom, 20)
                    } else {
                        Image("plus_photo")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.white)
                            .scaledToFit()
                            .frame(width: 120)
                            .padding(.bottom, 20)
                    }
                     
                }
                .sheet(isPresented: $showImagePicker) {
                    configImage()
                } content: {
                    ImagePicker(uiimage: $selectedUiImage)
                }
                
                TextFieldView(placeHolder: "Email", image_name: "envelope", text: $email)
                    .padding(.horizontal)

                TextFieldView(placeHolder: "Full Name", image_name: "person", text: $fullName)
                    .padding(.horizontal)
                
                TextFieldView(placeHolder: "User Name", image_name: "person", text: $userName)
                    .padding(.horizontal)
                
                PasswordTextFieldView(placeHolder: "Password", text: $password)
                    .padding(.horizontal)
                
                Button {
                    guard let selectedUiImage = selectedUiImage else { return }
                    viewModel.registerUser(email: email, password: password, username: userName, fullname: fullName, profileImage: selectedUiImage)
                } label: {
                    Text("Sign Up")
                        .frame(width: screenWidth - 40, height: 40)
                        .background(.white)
                        .cornerRadius(20)
                }
                .padding(.top, 40)
                .disabled(viewModel.isLoading)
                
                Spacer()
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Already have an account")
                        .foregroundColor(.white)
                }
            }
                .background(background_color)
            
            ActivityIndicatorView(isVisible: $viewModel.isLoading, type: .default)
                .frame(width: 60, height: 60)
                .foregroundColor(.white)
        }
        .present(isPresented: $viewModel.errorToastPresent, type: .toast, position: .top, closeOnTap: true, closeOnTapOutside: true) {
            ToastErrorView(message: viewModel.error?.localizedDescription ?? "회원가입에 실패하였습니다.")
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
