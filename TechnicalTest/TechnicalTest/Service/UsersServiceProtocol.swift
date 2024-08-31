//
//  UsersServiceProtocol.swift
//  TechnicalTest
//
//  Created by Fadhl Nader on 29/08/2024.
//

import Foundation

protocol UsersServiceProtocol {
    func fetchUsers() async throws -> [User]
    func isConnectedToNetwork() async -> Bool
}
