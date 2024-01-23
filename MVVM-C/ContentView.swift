//
//  ContentView.swift
//  MVVM-C
//
//  Created by Davidyoon on 1/23/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var appCoordinator = AppCoordinator(path: NavigationPath())
    
    var body: some View {
        NavigationStack(path: $appCoordinator.path) {
            appCoordinator.build()
                .navigationDestination(for: UserFlowCoordinator.self) { coordinator in
                    coordinator.build()
                }
                .navigationDestination(for: SettingsFlowCoordinator.self) { coordinator in
                    coordinator.build()
                }
                .navigationDestination(for: ProfileFlowCoordinator.self) { coordinator in
                    coordinator.build()
                }
        }
        .environmentObject(appCoordinator)
    }
}

#Preview {
    ContentView()
}
