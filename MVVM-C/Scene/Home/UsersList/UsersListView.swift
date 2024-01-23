//
//  UsersListView.swift
//  MVVM-C
//
//  Created by Davidyoon on 1/23/24.
//

import SwiftUI
import Combine

struct UsersListView: View {
    
    @StateObject var viewModel: UsersListViewModel
    
    let didClickUser = PassthroughSubject<User, Never>()
    
    var body: some View {
        List {
            ForEach(viewModel.users) { user in
                Button(action: {
                    didClickUser.send(user)
                }, label: {
                    Text(user.name)
                })
            }
        }
        .navigationTitle("Users")
        .onAppear {
            viewModel.fetchUsers()
        }
    }
}

#Preview {
    UsersListView(viewModel: UsersListViewModel())
}
