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
            SearchBar(text: $searchTest)
            VStack {
                ForEach(0..<10) { _ in
                    Text("add user here..")
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
