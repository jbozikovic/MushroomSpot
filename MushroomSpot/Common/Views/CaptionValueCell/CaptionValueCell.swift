//
//  CaptionValueCell.swift
//  MushroomSpot
//
//  Created by Jurica Bozikovic on 28.02.2024..
//  Copyright © 2024 CocodeLab. All rights reserved.
//

import UIKit

// MARK: - CaptionValueCellConstants
private struct CaptionValueCellConstants {
    private init() {}
    
    static let valueNumberOfLines: Int = 0
    static let offset: CGFloat = 10.0
    static let leadingTrailingOffset: CGFloat = 20.0
    static let labelHeight: CGFloat = 21.0
}


// MARK: - CaptionValueCell
class CaptionValueCell: UITableViewCell, Configurable {
    typealias T = CaptionValueCellViewModel
    lazy var captionLabel = UILabel(frame: .zero)
    lazy var valueLabel = UILabel(frame: .zero)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupGUI()
    }
    
    func configure(_ item: CaptionValueCellViewModel) {
        setupGUI()
        captionLabel.text = item.caption.uppercased()
        valueLabel.text = item.value
    }
}


// MARK: - Setup GUI
private extension CaptionValueCell {
    func setupGUI() {
        backgroundColor = .clear
        selectionStyle = .none
        addSubviews()
        Utility.setupLabel(captionLabel, font: AppUI.titleFont, textColor: AppUI.titleFontColor)
        Utility.setupLabel(valueLabel, font: AppUI.defaultFont, textColor: AppUI.bodyFontColor, numberOfLines: CaptionValueCellConstants.valueNumberOfLines)
        setupConstraints()
    }
    
    func addSubviews() {
        [captionLabel, valueLabel].forEach { subView in
            addSubview(subView)
        }
    }
}


// MARK: - Setup constraints
private extension CaptionValueCell {
    func setupConstraints() {
        setupCaptionConstraints()
        setupValueConstraints()
    }
    
    func setupCaptionConstraints() {
        captionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CaptionValueCellConstants.offset)
            make.leading.equalToSuperview().offset(CaptionValueCellConstants.leadingTrailingOffset)
            make.trailing.equalToSuperview().offset(-CaptionValueCellConstants.leadingTrailingOffset)
            make.height.equalTo(CaptionValueCellConstants.labelHeight)
        }
    }

    func setupValueConstraints() {
        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(captionLabel.snp.bottom).offset(CaptionValueCellConstants.offset)
            make.leading.equalTo(captionLabel.snp.leading)
            make.trailing.equalToSuperview().offset(-CaptionValueCellConstants.leadingTrailingOffset)
            make.bottom.equalToSuperview().offset(-CaptionValueCellConstants.offset)
            make.height.greaterThanOrEqualTo(CaptionValueCellConstants.labelHeight)
        }
    }
}


// MARK: - Reusable
extension CaptionValueCell: Reusable {
    static var estimatedHeight: CGFloat {
        return 100.0
    }
}
