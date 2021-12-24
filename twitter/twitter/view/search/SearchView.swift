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
    @ObservedObject var viewModel = ViewModelDependency.resolve().searchViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                SearchBar(text: $searchTest)
                    .padding(.top)
                VStack {
                    ForEach(searchTest.isEmpty ? viewModel.users : viewModel.filteredUsers(query: searchTest)) { user in
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
