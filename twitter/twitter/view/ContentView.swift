//
//  ContentView.swift
//  twitter
//
//  Created by 신동규 on 2021/11/17.
//

import SwiftUI

struct ContentView: View {
    
    @State var shouldLogin = true
    
    var body: some View {
        NavigationView {
            TabView {
                FeedView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }

                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }

                ConversationListView()
                    .tabItem {
                        Image(systemName: "envelope")
                        Text("Messages")
                    }
            }

            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
