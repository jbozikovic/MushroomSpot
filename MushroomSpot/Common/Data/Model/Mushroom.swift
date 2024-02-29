//
//  Mushroom.swift
//  MushroomSpot
//
//  Created by Jurica Bozikovic on 27.02.2024..
//  Copyright © 2024 CocodeLab. All rights reserved.
//

import Foundation

//  MARK: - MushroomReponse
struct MushroomReponse: Codable {
    var mushrooms: [Mushroom]
    
    // MARK: - CodingKeys
    private enum CodingKeys: String, CodingKey {
        case mushrooms = "mushrooms"
    }
}

//  MARK: - Mushroom
struct Mushroom: Codable {
    var id: String
    var name: String
    var latinName: String
    var profilePicture: String
    
    // MARK: - CodingKeys
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case latinName = "latin_name"
        case profilePicture = "profile_picture"
    }
}
