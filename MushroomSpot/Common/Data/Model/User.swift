//
//  User.swift
//  MushroomSpot
//
//  Created by Jurica Bozikovic on 27.02.2024..
//  Copyright © 2024 CocodeLab. All rights reserved.
//

import Foundation

//  MARK: - UserReponse
struct UserReponse: Codable {
    var user: User

    // MARK: - CodingKeys
    private enum CodingKeys: String, CodingKey {
        case user = "user"
    }
}

//  MARK: - User
struct User: Codable {
    var id: String
    var username: String
    var firstName: String
    var lastName: String
    
    // MARK: - CodingKeys
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case username = "username"
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

extension User {
    var fullName: String {
        "\(firstName) \(lastName)"
    }
}
