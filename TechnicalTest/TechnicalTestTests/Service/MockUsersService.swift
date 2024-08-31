//
//  MockUsersService.swift
//  TechnicalTestTests
//
//  Created by Fadhl Nader on 30/08/2024.
//

@testable import TechnicalTest

final class MockUsersService: UsersServiceProtocol {

    func fetchUsers() async throws -> [User] {
        let mockAPICall = MockAPICall()
        let apiClient = UsersService(networkClient: mockAPICall)
        return try await apiClient.fetchUsers() 
    }

    func isConnectedToNetwork() async -> Bool {
        return(true) // Always assume network is available for simplicity
    }
   
}
