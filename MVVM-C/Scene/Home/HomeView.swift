//
//  HomeView.swift
//  MVVM-C
//
//  Created by Davidyoon on 1/23/24.
//

import SwiftUI
import Combine

struct HomeView: View {
    
    let didClickMenuItem = PassthroughSubject<HomeMenu, Never>()
    
    @State var menuItems = HomeMenu.allCases
    
    var body: some View {
        List {
            ForEach(menuItems, id: \.self) { item in
                Button(action: {
                    didClickMenuItem.send(item)
                }, label: {
                    Text(item.rawValue)
                })
            }
        }
        .navigationTitle("MVVMC DEMO")
    }
    
}

#Preview {
    HomeView()
}
