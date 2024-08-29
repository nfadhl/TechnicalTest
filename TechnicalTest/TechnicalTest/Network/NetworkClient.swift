//
//  NetworkClient.swift
//  TechnicalTest
//
//  Created by Fadhl Nader on 29/08/2024.
//

import Foundation

final class NetworkClient: NetworkClientProtocol {
    
    func makeAPICall(url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        // No response from the server
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.failed
        }
        switch httpResponse.statusCode {
            // Code 200, let's check if the data exists
            case (200...299):
               return data
            default:
                throw NetworkError.notFound
        }
    }
}
