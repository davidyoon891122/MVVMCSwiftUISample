//
//  UsersListViewModel.swift
//  MVVM-C
//
//  Created by Davidyoon on 1/23/24.
//

import Foundation

final class UsersListViewModel: ObservableObject {
    
    @Published var users: [User] = []
    
    func fetchUsers() {
        self.users = User.users
    }
    
}
