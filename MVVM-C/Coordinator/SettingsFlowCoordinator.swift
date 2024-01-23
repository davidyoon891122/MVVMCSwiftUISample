//
//  SettingsFlowCoordinator.swift
//  MVVM-C
//
//  Created by Davidyoon on 1/23/24.
//

import SwiftUI
import Combine

enum SettingsPage: String, Identifiable {
    case main, privacy, custom
    
    var id: String {
        self.rawValue
    }
}

final class SettingsFlowCoordinator: ObservableObject {
    
    @Published var page: SettingsPage
    
    private var id: UUID
    private var cancellables: Set<AnyCancellable> = []
    
    let pushCoordinator: PassthroughSubject<SettingsFlowCoordinator, Never> = .init()
    
    init(page: SettingsPage) {
        self.id = UUID()
        self.page = page
    }
    
    @ViewBuilder
    func build() -> some View {
        switch self.page {
        case .main:
            mainSettingsView()
        case .privacy:
            privacySettingsView()
        case .custom:
            customSettingsView()
        }
    }
    
}

extension SettingsFlowCoordinator: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: SettingsFlowCoordinator, rhs: SettingsFlowCoordinator) -> Bool {
        lhs.id == rhs.id
    }
    
}

private extension SettingsFlowCoordinator {
    
    func mainSettingsView() -> some View {
        let mainSettingsView = MainSettingsView()
        bind(view: mainSettingsView)
        
        return mainSettingsView
    }
    
    func privacySettingsView() -> some View {
        let privacySettingsView = PrivacySettingsView()
        
        return privacySettingsView
    }
    
    func customSettingsView() -> some View {
        let customSettingsView = CustomSettingsView()
        
        return customSettingsView
    }
    
    
    func bind(view: MainSettingsView) {
        view.didClickPrivacy
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] didClick in
                if didClick {
                    self?.showPrivacySettings()
                }
            })
            .store(in: &cancellables)
        
        view.didClickCustom
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] didClick in
                if didClick {
                    self?.showCustomSettings()
                }
            })
            .store(in: &cancellables)
    }
}

private extension SettingsFlowCoordinator {
    
    func showPrivacySettings() {
        pushCoordinator.send(SettingsFlowCoordinator(page: .privacy))
    }
    
    func showCustomSettings() {
        pushCoordinator.send(SettingsFlowCoordinator(page: .custom))
    }
    
}
