//
//  UserDetailsView.swift
//  MVVM-C
//
//  Created by Davidyoon on 1/23/24.
//

import SwiftUI

struct UserDetailsView: View {
    
    @StateObject var viewModel: UserDetailsViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.profile?.name ?? "N/A")
                .font(.title)
            if let age = viewModel.profile?.age {
                Text("Age: \(String(age))")
            } else {
                Text("Age: Unknown")
            }
            Text("Occupation: \(viewModel.profile?.occupation ?? "N/A")")
            Spacer()
        }
        .padding()
        .navigationTitle("USER DETAILS")
        .onAppear {
            viewModel.fetchProfile()
        }
    }
    
}

#Preview {
    UserDetailsView(viewModel: UserDetailsViewModel(userId: 5))
}
