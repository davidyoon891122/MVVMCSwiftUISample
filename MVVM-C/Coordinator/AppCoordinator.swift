//
//  AppCoordinator.swift
//  MVVM-C
//
//  Created by Davidyoon on 1/23/24.
//

import SwiftUI
import Combine

final class AppCoordinator: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var path: NavigationPath
    
    init(path: NavigationPath) {
        self.path = path
    }
    
    @ViewBuilder
    func build() -> some View {
        homeView()
    }
    
    
}

private extension AppCoordinator {
    
    func homeView() -> some View {
        let homeView = HomeView()
        bind(view: homeView)
        return homeView
    }
    
    func push<T: Hashable>(_ coordinator: T) {
        print(coordinator)
        path.append(coordinator)
    }
    
    func bind(view: HomeView) {
        view.didClickMenuItem
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] item in
                switch item {
                case .users:
                    self?.usersFlow()
                case .settings:
                    self?.settingsFlow()
                case .profile:
                    self?.profileFlow()
                }
            })
            .store(in: &cancellables)
    }
    
    func usersFlow() {
        let usersFlowCoordinator = UserFlowCoordinator(page: .users)
        self.bind(userFlowCoordinator: usersFlowCoordinator)
        self.push(usersFlowCoordinator)
    }
    
    func settingsFlow() {
        let settingsFlowCoordinator = SettingsFlowCoordinator(page: .main)
        self.bind(settingsFlowCoordinator: settingsFlowCoordinator)
        self.push(settingsFlowCoordinator)
    }
    
    func profileFlow() {
        let profileFlowCoordinator = ProfileFlowCoordinator(page: .main)
        bind(profileFlowCoordinator: profileFlowCoordinator)
        self.push(profileFlowCoordinator)
    }
    
}

private extension AppCoordinator {
    
    func bind(userFlowCoordinator: UserFlowCoordinator) {
        userFlowCoordinator.pushCoordinator
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] coordinator in
                self?.push(coordinator)
            })
            .store(in: &cancellables)
    }
    
    func bind(settingsFlowCoordinator: SettingsFlowCoordinator) {
        settingsFlowCoordinator.pushCoordinator
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] coordinator in
                self?.push(coordinator)
            })
            .store(in: &cancellables)
    }
    
    func bind(profileFlowCoordinator: ProfileFlowCoordinator) {
        profileFlowCoordinator.pushCoordinator
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] coordinator in
                self?.push(coordinator)
            })
            .store(in: &cancellables)
    }
    
}


enum HomeMenu: String, CaseIterable {
    case users = "Users"
    case settings = "Settings"
    case profile = "Profile"
}
