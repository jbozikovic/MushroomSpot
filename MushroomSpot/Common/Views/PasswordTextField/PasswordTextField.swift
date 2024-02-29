//
//  PasswordTextField.swift
//  MushroomSpot
//
//  Created by Jurica Bozikovic on 28.02.2024..
//  Copyright © 2024 CocodeLab. All rights reserved.
//

import UIKit

class PasswordTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupGUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupGUI()
    }
    
    private func setupGUI() {
        isSecureTextEntry = true
        rightView = togglePasswordVisibilityButton()
        rightViewMode = .always
    }
    
    private func togglePasswordVisibilityButton() -> UIButton {
        let btn = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: AppUI.passwordVisibilityBtnSize, height: AppUI.passwordVisibilityBtnSize))
        btn.setImage(AppImages.visibleIcon.image, for: .normal)
        btn.setImage(AppImages.invisibleIcon.image, for: .selected)
        btn.addTarget(self, action: #selector(togglePasswordVisibility(_:)), for: .touchUpInside)
        return btn
    }
    
    @objc private func togglePasswordVisibility(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.isSecureTextEntry = !sender.isSelected
    }
}

