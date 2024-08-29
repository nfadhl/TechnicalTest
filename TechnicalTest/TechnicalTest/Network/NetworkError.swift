//
//  NetworkError.swift
//  TechnicalTest
//
//  Created by Fadhl Nader on 29/08/2024.
//

import Foundation

enum NetworkError: String, Error {
    case notFound = "Error 404"
    case invalidURL = "Error: Invalid URL"
    case decodeError = "Error decoding data"
    case failed = "An error occurred"
}
