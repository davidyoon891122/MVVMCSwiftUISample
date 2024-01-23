//
//  MainProfileView.swift
//  MVVM-C
//
//  Created by Davidyoon on 1/23/24.
//

import SwiftUI
import Combine

struct MainProfileView: View {
    
    let didClickPersonal = PassthroughSubject<Bool, Never>()
    let didClickEducation = PassthroughSubject<Bool, Never>()
    
    var body: some View {
        List {
            Button(action: {
                didClickPersonal.send(true)
            }, label: {
                Text("Personal Details")
            })
            
            Button(action: {
                didClickEducation.send(true)
            }, label: {
                Text("Education Details")
            })
        }
        .navigationTitle("Profile")
    }
    
}

#Preview {
    MainProfileView()
}
