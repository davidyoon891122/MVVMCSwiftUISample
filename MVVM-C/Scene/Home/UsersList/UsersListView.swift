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
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.users) { user in
                    Button(action: {
                        viewModel.moveToUserDetails(user: user)
                    }, label: {
                        Text(user.name)
                    })
                }
            }
            .navigationTitle("Users")
            .onAppear {
                viewModel.fetchUsers()
            }
            Spacer()
            Button(action: {
                viewModel.moveToNext()
            }, label: {
                Text("Go to Next Page")
            })
        }
    }
}

#Preview {
    UsersListView(viewModel: UsersListViewModel())
}
