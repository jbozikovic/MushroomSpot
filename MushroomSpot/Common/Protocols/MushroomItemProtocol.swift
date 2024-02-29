//
//  MushroomItemProtocol.swift
//  MushroomSpot
//
//  Created by Jurica Bozikovic on 29.02.2024..
//  Copyright © 2024 CocodeLab. All rights reserved.
//

import UIKit

protocol MushroomItemProtocol {
    var mushroom: Mushroom { get }
    var title: String { get }
    var imageUrl: URL? { get }
    var placeholderImage: UIImage? { get }
}

extension MushroomItemProtocol {
    var title: String {
        mushroom.name
    }
    var imageUrl: URL? {
        mushroom.profilePicture.toURL
    }
    var placeholderImage: UIImage? {
        return AppImages.noImage.image
    }
}
