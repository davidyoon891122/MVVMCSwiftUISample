//
//  UsersListViewModel.swift
//  MVVM-C
//
//  Created by Davidyoon on 1/23/24.
//

import Foundation
import Combine

final class UsersListViewModel: ObservableObject {
    
    @Published var users: [User] = []
    
    let moveToNextSubject: PassthroughSubject<Bool, Never> = .init()
    let moveToUserSubject: PassthroughSubject<User, Never> = .init()
    
    func fetchUsers() {
        self.users = User.users
    }
    
    func moveToNext() {
        moveToNextSubject.send(true)
    }
    
    func moveToUserDetails(user: User) {
        moveToUserSubject.send(user)
    }
    
}
