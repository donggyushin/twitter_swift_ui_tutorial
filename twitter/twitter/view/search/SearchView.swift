//
//  SearchView.swift
//  twitter
//
//  Created by 신동규 on 2021/11/17.
//

import SwiftUI
import LazyViewSwiftUI

struct SearchView: View {
    
    @State var searchTest: String = ""
    @ObservedObject var viewModel = SearchViewModel(userRepository: RepositoryDependency.resolve().userRepository)
    
    var body: some View {
        ScrollView {
            VStack {
                SearchBar(text: $searchTest)
                    .padding(.top)
                VStack {
                    ForEach(viewModel.users) { user in
                        NavigationLink {
                            LazyView(ProfileView(user: user))
                        } label: {
                            UserCell(user: user)
                                .padding(.horizontal)
                        }
                    }
                }
                .padding(.vertical)
            }
        }
        .padding(.top, 1)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
