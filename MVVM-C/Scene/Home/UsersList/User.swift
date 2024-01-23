//
//  User.swift
//  MVVM-C
//
//  Created by Davidyoon on 1/23/24.
//

import Foundation

struct User: Identifiable {
    
    let id: Int
    let name: String
    
}

extension User {
    
    static let users: [User] = [
        User(id: 1, name: "User 1"),
        User(id: 2, name: "User 2"),
        User(id: 3, name: "User 3")
    ]
    
}
