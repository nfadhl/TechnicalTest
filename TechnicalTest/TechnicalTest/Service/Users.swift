//
//  Users.swift
//  TechnicalTest
//
//  Created by Fadhl Nader on 29/08/2024.
//

import Foundation

// MARK: - Response
struct Users: Codable {
    let results: [User]
    let info: Info
}

// MARK: - User
struct User: Codable {
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let login: Login
    let dob: DOB
    let registered: Registered
    let phone: String
    let cell: String
    let id: ID?
    let picture: Picture
    let nat: String
}

// MARK: - Name
struct Name: Codable {
    let title: String
    let first: String
    let last: String
}

// MARK: - Location
struct Location: Codable {
    let street: Street
    let city: String
    let state: String
    let country: String
    let coordinates: Coordinates
    let timezone: Timezone
}

// MARK: - Street
struct Street: Codable {
    let number: Int
    let name: String
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude: String
    let longitude: String
}

// MARK: - Timezone
struct Timezone: Codable {
    let offset: String
    let description: String
}

// MARK: - Login
struct Login: Codable {
    let uuid: String
    let username: String
    let password: String
    let salt: String
    let md5: String
    let sha1: String
    let sha256: String
}

// MARK: - DOB
struct DOB: Codable {
    let date: String
    let age: Int
}

// MARK: - Registered
struct Registered: Codable {
    let date: String
    let age: Int
}

// MARK: - ID
struct ID: Codable {
    let name: String
    let value: String?
}

// MARK: - Picture
struct Picture: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}

// MARK: - Info
struct Info: Codable {
    let seed: String
    let results: Int
    let page: Int
    let version: String
}
