//
//  ContentViewModel.swift
//  twitter
//
//  Created by 신동규 on 2021/12/25.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var currentTab = 0
    
    func navigationTitle() -> String {
        switch currentTab {
        case 1: return "Search"
        case 2: return "Message"
        default: return "Home"
        }
    }
}
