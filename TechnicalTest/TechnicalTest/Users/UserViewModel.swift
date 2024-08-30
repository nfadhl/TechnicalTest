//
//  UserViewModel.swift
//  TechnicalTest
//
//  Created by Fadhl Nader on 30/08/2024.
//

import Foundation

final class UserViewModel: Identifiable, Codable {
    
    var user: User
    var name: String
    var email: String
    var image: String
    
    init(user: User) {
        self.user = user
        self.name = "\(user.name.title) \(user.name.first) \(user.name.last)"
        self.email = user.email
        self.image = user.picture.thumbnail
    }
}
