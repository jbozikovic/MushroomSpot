//
//  MushroomCellViewModel.swift
//  MushroomSpot
//
//  Created by Jurica Bozikovic on 28.02.2024..
//  Copyright © 2024 CocodeLab. All rights reserved.
//

import UIKit

class MushroomCellViewModel: MushroomItemProtocol {
    var mushroom: Mushroom
    
    init(mushroom: Mushroom) {
        self.mushroom = mushroom
    }
}
