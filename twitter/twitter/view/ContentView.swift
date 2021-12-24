//
//  ContentView.swift
//  twitter
//
//  Created by 신동규 on 2021/11/17.
//

import SwiftUI
import Kingfisher
import Combine
import LazyViewSwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var viewModel: ContentViewModel = ViewModelDependency.resolve().contentViewModel
    
    var body: some View {
        Group {
            if authViewModel.userSession != nil {
                NavigationView {
//                    TabView
                    TabView(selection: $viewModel.currentTab)
                    {
                        FeedView()
                            .tabItem {
                                Image(systemName: "house")
                                Text("Home")
                            }
                            .tag(0)
                        SearchView()
                            .tabItem {
                                Image(systemName: "magnifyingglass")
                                Text("Search")
                            }
                            .tag(1)
                        ConversationListView()
                            .tabItem {
                                Image(systemName: "envelope")
                                Text("Messages")
                            }
                            .tag(2)
                        
                    }
                    .navigationTitle(viewModel.navigationTitle())
                    .toolbar(content: {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                authViewModel.signOut()
                            } label: {
                                KFImage(.init(string: authViewModel.user?.profileImageUrl ?? ""))
                                    .resizable()
                                    .scaledToFill()
                                    .clipped()
                                    .frame(width: 32, height: 32)
                                    .clipShape(Circle())
                            }

                        }
                    })
                    .navigationBarTitleDisplayMode(.inline)
                }
            } else {
                LoginView()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
