//
//  UserFlowCoordinator.swift
//  MVVM-C
//
//  Created by Davidyoon on 1/23/24.
//

import SwiftUI
import Combine

enum UserPage: String, Identifiable {
    case users, profile
    
    var id: String {
        self.rawValue
    }
    
}


final class UserFlowCoordinator: ObservableObject {
    
    @Published var page: UserPage
    
    private var id: UUID
    private var userId: Int?
    private var cancellables: Set<AnyCancellable> = []
    
    let pushCoordinator = PassthroughSubject<UserFlowCoordinator, Never>()
    
    init(page: UserPage, userID: Int? = nil) {
        self.id = UUID()
        self.page = page
        
        if page == .profile {
            guard let userID = userID else {
                fatalError("userID must be provided for profile type")
            }
            self.userId = userID
        }
    }
    
    @ViewBuilder
    func build() -> some View {
        switch self.page {
        case .users:
            usersListView()
        case .profile:
            userDetailsView()
        }
    }
    
}

extension UserFlowCoordinator: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: UserFlowCoordinator, rhs:UserFlowCoordinator) -> Bool {
        lhs.id == rhs.id
    }
    
}

private extension UserFlowCoordinator {
    
    func usersListView() -> some View {
        let viewModel = UsersListViewModel()
        let usersListView = UsersListView(viewModel: viewModel)
        bind(view: usersListView)
        
        return usersListView
    }
    
    func userDetailsView() -> some View {
        let viewModel = UserDetailsViewModel(userId: userId ?? 0)
        let userDetailsView = UserDetailsView(viewModel: viewModel)
        
        return userDetailsView
    }
    
    func bind(view: UsersListView) {
        view.didClickUser
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] user in
                self?.showUserProfile(for: user)
            })
            .store(in: &cancellables)
    }
    
}

private extension UserFlowCoordinator {
    
    func showUserProfile(for user: User) {
        pushCoordinator.send(UserFlowCoordinator(page: .profile, userID: user.id))
    }
    
}
