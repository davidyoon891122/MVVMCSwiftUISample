//
//  ProfileFlowCoordinator.swift
//  MVVM-C
//
//  Created by Davidyoon on 1/23/24.
//

import SwiftUI
import Combine

enum ProfilePage: String, Identifiable {
    case main, personal, education
    
    var id: String {
        self.rawValue
    }
}

final class ProfileFlowCoordinator: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let id: UUID
    
    let pushCoordinator: PassthroughSubject<ProfileFlowCoordinator, Never> = .init()
    
    @Published var page: ProfilePage
    
    init(page: ProfilePage) {
        self.id = UUID()
        
        self.page = page
    }
    
    
    @ViewBuilder
    func build() -> some View {
        switch self.page {
        case .main:
            mainProfileView()
        case .personal:
            personalDetailsView()
        case .education:
            educationDetailsView()
        }
    }
    
    
    
}

extension ProfileFlowCoordinator: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: ProfileFlowCoordinator, rhs: ProfileFlowCoordinator) -> Bool {
        lhs.id == rhs.id
    }
    
}

private extension ProfileFlowCoordinator {
    
    func mainProfileView() -> some View {
        let mainProfileView = MainProfileView()
        bind(view: mainProfileView)
        return mainProfileView
    }
    
    func personalDetailsView() -> some View {
        let personalDetailsView = PersonalDetailsView()
        
        return personalDetailsView
    }
    
    func educationDetailsView() -> some View {
        let educationDetailsView = EducationDetailsView()
        
        return educationDetailsView
    }
    
    func bind(view: MainProfileView) {
        view.didClickPersonal
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] didClick in
                if didClick {
                    self?.showPersonalDetails()
                }
            })
            .store(in: &cancellables)
        
        view.didClickEducation
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] didClick in
                if didClick {
                    self?.showEducationDetails()
                }
            })
            .store(in: &cancellables)
    }
    
}

private extension ProfileFlowCoordinator {
    
    func showPersonalDetails() {
        pushCoordinator.send(ProfileFlowCoordinator(page: .personal))
    }
    
    func showEducationDetails() {
        pushCoordinator.send(ProfileFlowCoordinator(page: .education))
    }
    
}
