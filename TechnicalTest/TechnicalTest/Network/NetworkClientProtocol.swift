//
//  NetworkClientProtocol.swift
//  TechnicalTest
//
//  Created by Fadhl Nader on 29/08/2024.
//

import Foundation

protocol NetworkClientProtocol {
    func makeAPICall(url: URL) async throws -> Data
}

