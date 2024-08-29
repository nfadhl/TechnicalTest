//
//  UsersService.swift
//  TechnicalTest
//
//  Created by Fadhl Nader on 29/08/2024.
//

import Foundation
import Network

final class UsersService: UsersServiceProtocol {
    
    private let networkClient: NetworkClientProtocol
    
    private var path: String {
        return (URLsManager.shared.getBaseURL() ?? "")
    }
    
    /// The network client used to make API requests.
    init(networkClient: NetworkClientProtocol = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    /// Fetches the list of users asynchronously from the API.
    func fetchUsers() async throws -> [User] {
        
        guard let url = URL(string: path) else {
            throw NetworkError.invalidURL
        }
        let data  = try await networkClient.makeAPICall(url: url)
        do {
            let response = try JSONDecoder().decode(Users.self, from: data)
            return response.results
        } catch {
            throw NetworkError.decodeError
        }
    }
    
    /// Checks whether the device is connected to a network.
    func isConnectedToNetwork(completion: @escaping (Bool) -> Void) {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkMonitor")
        
        monitor.pathUpdateHandler = { path in
            completion(path.status == .satisfied)
        }
        monitor.start(queue: queue)
    }
}

