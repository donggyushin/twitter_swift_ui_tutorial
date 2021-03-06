//
//  NewTweetView.swift
//  twitter
//
//  Created by 신동규 on 2021/11/19.
//

import SwiftUI
import Kingfisher

struct NewTweetView: View {
    
    @Binding var isShowingNewTweetView: Bool
    @State var textEditorText: String = ""
    @ObservedObject var uploadTweetViewModel: UploadTweetViewModel
    @EnvironmentObject var viewModel: AuthViewModel
    
    init(isPresented: Binding<Bool>) {
        self._isShowingNewTweetView = isPresented
        self.uploadTweetViewModel = ViewModelDependency.resolve().uploadTweetViewModelFactory(isPresented)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .top) {
                    KFImage(.init(string: viewModel.user?.profileImageUrl ?? ""))
                        .resizable()
                        .frame(width: 56, height: 56)
                        .clipShape(Circle())
                        .scaledToFill()
                        .padding(.leading)
                    
                    TextAreaView(placeHolder: "What's happening?", text: $textEditorText)
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
                uploadTweetViewModel.uploadTweet(caption: textEditorText)
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
        NewTweetView(isPresented: .constant(true))
    }
}
