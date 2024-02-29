//
//  MushroomsCell.swift
//  MushroomSpot
//
//  Created by Jurica Bozikovic on 28.02.2024..
//  Copyright © 2024 CocodeLab. All rights reserved.
//

import UIKit
import SDWebImage

// MARK: - MushroomsCellConstants
private struct MushroomsCellConstants {
    private init() {}
        
    static let offset: CGFloat = 10.0
    static let leadingTrailingOffset: CGFloat = 20.0
    static let labelHeight: CGFloat = 21.0
}

// MARK: - MushroomsCell
class MushroomsCell: UITableViewCell, Configurable {
    typealias T = MushroomCellViewModel
    lazy var titleLabel = UILabel(frame: .zero)
    lazy var thumbImageView = UIImageView(frame: .zero)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(_ item: MushroomCellViewModel) {
        setupGUI()
        titleLabel.text = item.title
        thumbImageView.sd_setImage(with: item.imageUrl, placeholderImage: item.placeholderImage)
    }
}


// MARK: - Setup GUI
private extension MushroomsCell {
    func setupGUI() {
        backgroundColor = .clear
        addSubviews()
        Utility.setupLabel(titleLabel, font: AppUI.listTitleFont, textColor: AppUI.titleFontColor)
        setupConstraints()
    }
    
    func addSubviews() {
        [titleLabel, thumbImageView].forEach { subView in
            addSubview(subView)
        }
    }
}


// MARK: - Setup constraints
private extension MushroomsCell {
    func setupConstraints() {
        setupTitleLabelConstraints()
        setupThumbImageViewConstraints()
    }

    func setupThumbImageViewConstraints() {
        thumbImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(MushroomsCellConstants.offset)
            make.bottom.equalToSuperview().offset(-MushroomsCellConstants.offset)
            make.trailing.equalToSuperview().offset(-MushroomsCellConstants.leadingTrailingOffset)
            make.width.equalTo(120)
            make.height.equalTo(120)
        }
    }
    
    func setupTitleLabelConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(MushroomsCellConstants.leadingTrailingOffset)
            make.trailing.equalTo(thumbImageView.snp.leading).offset(-MushroomsCellConstants.offset)
            make.height.equalTo(MushroomsCellConstants.labelHeight)
        }
    }
}


// MARK: - Reusable
extension MushroomsCell: Reusable {
    static var estimatedHeight: CGFloat {
        return 170.0
    }
}
