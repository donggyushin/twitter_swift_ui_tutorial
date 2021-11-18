//
//  ProfileView.swift
//  twitter
//
//  Created by 신동규 on 2021/11/18.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView {
            ProfileHeaderView()
                .padding(.top)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
