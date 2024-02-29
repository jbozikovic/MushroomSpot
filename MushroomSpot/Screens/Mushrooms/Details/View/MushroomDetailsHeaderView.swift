//
//  MushroomDetailsHeaderView.swift
//  MushroomSpot
//
//  Created by Jurica Bozikovic on 28.02.2024..
//  Copyright © 2024 CocodeLab. All rights reserved.
//

import UIKit
import SDWebImage

// MARK: - EmployeeDetailsHeaderViewConstants
private struct EmployeeDetailsHeaderViewConstants {
    private init() {}

    static let nameNumberOfLines: Int = 2
    static let introNumberOfLines: Int = 0
    static let offset: CGFloat = 10.0
    static let avatarSize: CGFloat = 200.0
    static let leadingTrailingOffset: CGFloat = 20.0
    static let labelHeight: CGFloat = 30.0
}


// MARK: - EmployeeDetailsHeaderView
class MushroomDetailsHeaderView: UITableViewHeaderFooterView, Configurable {
    typealias T = MushroomDetailsHeaderViewModel
    lazy var nameLabel = UILabel(frame: .zero)
    lazy var thumbImageView = UIImageView(frame: .zero)
    
    private var viewModel: MushroomDetailsHeaderViewModel?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupGUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
                
    func configure(_ item: MushroomDetailsHeaderViewModel) {
        self.viewModel = item
        thumbImageView.sd_setImage(with: item.imageUrl, placeholderImage: item.placeholderImage)
        nameLabel.text = item.title
    }
}


// MARK: - Setup GUI
private extension MushroomDetailsHeaderView {
    func setupGUI() {
        addSubviews()
        thumbImageView.tintColor = .gray
        Utility.setupLabel(nameLabel, font: AppUI.titleFont, textColor: AppUI.titleFontColor, numberOfLines: EmployeeDetailsHeaderViewConstants.nameNumberOfLines, textAlignment: NSTextAlignment.center)
        setupConstraints()
    }
    
    func addSubviews() {
        [thumbImageView, nameLabel].forEach { subView in
            addSubview(subView)
        }
    }
}


// MARK: - Setup constraints
private extension MushroomDetailsHeaderView {
    func setupConstraints() {
        setupNameConstraints()
        setupAvatarConstraints()
    }
    
    func setupNameConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(EmployeeDetailsHeaderViewConstants.offset)
            make.leading.equalToSuperview().offset(EmployeeDetailsHeaderViewConstants.leadingTrailingOffset)
            make.trailing.equalToSuperview().offset(-EmployeeDetailsHeaderViewConstants.leadingTrailingOffset)
            make.height.greaterThanOrEqualTo(EmployeeDetailsHeaderViewConstants.labelHeight)
        }
    }
    
    func setupAvatarConstraints() {
        thumbImageView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(EmployeeDetailsHeaderViewConstants.offset)
            make.centerX.equalToSuperview()
            make.width.equalTo(EmployeeDetailsHeaderViewConstants.avatarSize)
//            make.height.equalTo(EmployeeDetailsHeaderViewConstants.avatarSize)
            make.bottom.equalToSuperview().offset(-EmployeeDetailsHeaderViewConstants.offset)
        }
    }
}


// MARK: - Reusable
extension MushroomDetailsHeaderView: Reusable {
    static var estimatedHeight: CGFloat {
        return 250.0
    }
}

