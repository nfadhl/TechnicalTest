//
//  UsersListViewModel.swift
//  TechnicalTest
//
//  Created by Fadhl Nader on 30/08/2024.
//

import Foundation
import Combine

@MainActor
final class UsersListViewModel {
    
    var usersUpdated = PassthroughSubject<Bool, Never>()
    var usersViewModel = [UserViewModel]()
    private let usersService: UsersServiceProtocol
    private var subscriptions = Set<AnyCancellable>()
    @Published var errorMessage: String?
    
    
    init(usersService: UsersServiceProtocol = UsersService()) {
        self.usersService = usersService
        fetchUsers()
    }
    
    /// Fetches the list of users, either from the API if the network is available or from the local cache if not.
    func fetchUsers() {
        Task {
            let isConnected = await self.usersService.isConnectedToNetwork()
            if isConnected {
                self.fetchUsersFromAPI()
            } else {
                self.loadUsersFromCache()
            }
        }
    }
    
    /// Fetches users from the API  and updates the `usersViewModel` array.
    private func fetchUsersFromAPI() {
        Task {
            do {
                let users = try await self.usersService.fetchUsers()
                users.forEach { usersViewModel.append(UserViewModel(user: $0)) }
                UserDefaults.standard.setCodableObject(usersViewModel, forKey: "users")
                usersUpdated.send(true)
            } catch {
                handleError(error)
            }
        }
    }
    
    /// Loads users from the local cache (stored in `UserDefaults`)
    private func loadUsersFromCache() {
        usersViewModel = UserDefaults.standard.codableObject(dataType: [UserViewModel].self, key: "users") ?? []
        usersUpdated.send(true)
    }
    
    /// Handles errors that occur during the fetching of user data.
    private func handleError(_ error: Error) {
        if let apiError = error as? NetworkError {
            self.errorMessage = apiError.rawValue
        } else {
            self.errorMessage = "An error occurred"
        }
        usersUpdated.send(false)
    }
    
    /// Refreshes the list of users  and fetching new data.
    func refreshUsers() {
        usersViewModel.removeAll()
        usersUpdated.send(true)
        fetchUsers()
    }
}

