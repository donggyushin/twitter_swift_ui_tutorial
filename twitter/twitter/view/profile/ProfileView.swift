//
//  ProfileView.swift
//  twitter
//
//  Created by 신동규 on 2021/11/18.
//

import SwiftUI

struct ProfileView: View {
    
    @State var selectedOption: TweetFilterOptions = .tweets
    
    var body: some View {
        ScrollView {
            VStack {
                ProfileHeaderView()
                    .padding(.top)
                
                FilterButtonsView(selectedOption: $selectedOption)
                    .padding(.vertical)
                
                ForEach(0..<9, content: { _ in
                    TweetCell()
                        .padding(.horizontal)
                        .padding(.bottom)
                })
            }
            .navigationTitle("Spider Man")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
