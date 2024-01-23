//
//  MainSettingsView.swift
//  MVVM-C
//
//  Created by Davidyoon on 1/23/24.
//

import SwiftUI
import Combine

struct MainSettingsView: View {
    
    let didClickPrivacy: PassthroughSubject<Bool, Never> = .init()
    let didClickCustom: PassthroughSubject<Bool, Never> = .init()
    
    var body: some View {
        List {
            Button(action: {
                didClickPrivacy.send(true)
            }, label: {
                Text("Privacy Settings")
            })
            
            Button(action: {
                didClickCustom.send(true)
            }, label: {
                Text("Custom Settings")
            })
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    MainSettingsView()
}
