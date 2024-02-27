//
//  URLFormatter.swift
//  MushroomSpot
//
//  Created by Jurica Bozikovic on 27.02.2024..
//  Copyright © 2024 CocodeLab. All rights reserved.
//

import Foundation

@propertyWrapper
struct URLFormatter {
    var wrappedValue: String {
        didSet {
            wrappedValue = wrappedValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? wrappedValue
        }
    }
    
    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? wrappedValue
    }
}
