//
//  UserDetailsViewModel.swift
//  MVVM-C
//
//  Created by Davidyoon on 1/23/24.
//

import Foundation

final class UserDetailsViewModel: ObservableObject {
    
    @Published var profile: Profile?
    
    private var userId: Int
    
    init(userId: Int) {
        self.userId = userId
    }
    
    func fetchProfile() {
        self.profile = .item
    }
    
}
