//
//  String+Extensions.swift
//  MushroomSpot
//
//  Created by Jurica Bozikovic on 27.02.2024..
//  Copyright © 2024 CocodeLab. All rights reserved.
//

import Foundation

// MARK: - Localized string
extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}

// MARK: - Convert to URL
extension String {
    var toURL: URL? {
        URL(string: self)
    }
}

// MARK: - Optional isNilOrEmpty
extension Optional where Wrapped == String {
    public var isNilOrEmpty: Bool {
        guard let unwrapped = self else { return true }
        return unwrapped.isEmpty
    }
}
