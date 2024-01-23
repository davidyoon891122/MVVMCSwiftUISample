//
//  Profile.swift
//  MVVM-C
//
//  Created by Davidyoon on 1/23/24.
//

import Foundation

struct Profile: Identifiable {
    let id: Int
    let name: String
    let age: Int
    let occupation: String
}

extension Profile {
    
    static let item: Self = .init(id: 05, name: "Jone Doe", age: 25, occupation: "Doctor")
    
}
