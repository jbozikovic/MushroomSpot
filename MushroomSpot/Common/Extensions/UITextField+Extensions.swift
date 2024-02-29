//
//  UITextField+Extensions.swift
//  MushroomSpot
//
//  Created by Jurica Bozikovic on 28.02.2024..
//  Copyright © 2024 CocodeLab. All rights reserved.
//

import UIKit

extension UITextField {
    func setPadding(left: CGFloat, right: CGFloat? = nil) {
        setLeftPadding(left)
        if let rightPadding = right {
            setRightPadding(rightPadding)
        }
    }
    
    private func setLeftPadding(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    private func setRightPadding(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func setIcon(image: UIImage?) {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 56.0, height: 16.0))
        let imageView = UIImageView(frame: CGRect(x: 20, y: 0, width: 16.0, height: 16.0))
        imageView.image = image
        containerView.addSubview(imageView)
        self.leftView = containerView
        self.leftViewMode = .always
    }
    
    func addBottomBorder(color: CGColor) {
        self.borderStyle = UITextField.BorderStyle.none
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: self.frame.width, height: 1.0)
        bottomLine.backgroundColor = color
        self.layer.addSublayer(bottomLine)
        self.layer.masksToBounds = true
    }
}

