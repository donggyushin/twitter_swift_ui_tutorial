//
//  SearchView.swift
//  twitter
//
//  Created by 신동규 on 2021/11/17.
//

import SwiftUI

struct SearchView: View {
    
    @State var searchTest: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                SearchBar(text: $searchTest)
                    .padding(.top)
                VStack {
                    ForEach(0..<20) { _ in
                        NavigationLink {
                            ProfileView()
                        } label: {
                            UserCell()
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
