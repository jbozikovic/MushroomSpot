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

// MARK: - String validations (email, password)
extension String {
    var isValidEmail: Bool {
        return NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
            .evaluate(with: self)
    }
    /** Check is password valid - must contain at least eight characters, at least one number and both lower and uppercase letters and special characters)
    @author Jurica Bozikovic
    */
    var isValidPassword: Bool {
        return NSPredicate(format: "SELF MATCHES %@", "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$")
            .evaluate(with: self)
    }
}
