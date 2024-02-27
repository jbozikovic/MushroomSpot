//
//  Reachability+Extensions.swift
//  MushroomSpot
//
//  Created by Jurica Bozikovic on 27.02.2024..
//  Copyright © 2024 CocodeLab. All rights reserved.
//

import Foundation

extension Reachability {
    var isReachableOnWiFi: Bool {
        return self.connection == .wifi
    }
    
    var isConnected: Bool {
        return self.connection != .none
    }
}
