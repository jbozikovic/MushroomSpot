//
//  MushroomDetailsViewModel.swift
//  MushroomSpot
//
//  Created by Jurica Bozikovic on 28.02.2024..
//  Copyright © 2024 CocodeLab. All rights reserved.
//

import Foundation
import Combine

//  MARK: - MushroomDetailsViewModelSection
enum MushroomDetailsViewModelSection: Int, CaseIterable {
    case id
    case name
    case latiName
                
    var title: String {
        switch self {
        case .id:
            return AppStrings.id.localized
        case .name:
            return AppStrings.name.localized
        case .latiName:
            return AppStrings.latinName.localized
        }
    }
}

//  MARK: - MushroomDetailsViewModel
class MushroomDetailsViewModel {
    private(set) var headerViewModel: MushroomDetailsHeaderViewModel?
    private var cellViewModels: [CaptionValueCellViewModel] = []
    private var cancellables = Set<AnyCancellable>()
    private var mushroom: Mushroom {
        didSet {
            prepareDataAndReload()
        }
    }
        
    // MARK: - Publishers
    lazy var shouldReloadData = PassthroughSubject<Void, Never>()
    
    init(mushroom: Mushroom) {
        self.mushroom = mushroom
        prepareDataAndReload()
    }
    
    //  MARK: - Load data
    private func prepareDataAndReload() {
        headerViewModel = MushroomDetailsHeaderViewModel(mushroom: mushroom)
        cellViewModels = [
            CaptionValueCellViewModel(caption: MushroomDetailsViewModelSection.id.title, value: mushroom.id),
            CaptionValueCellViewModel(caption: MushroomDetailsViewModelSection.name.title, value: mushroom.name),
            CaptionValueCellViewModel(caption: MushroomDetailsViewModelSection.latiName.title, value: mushroom.latinName)
        ]
        shouldReloadData.send()
    }
}


//  MARK: - Number of items,views visibility...
extension MushroomDetailsViewModel {
    var numberOfItems: Int {
        cellViewModels.count
    }
    var numberOfSections: Int {
        Constants.defaultNumberOfSections
    }
        
    func getItemAtIndex(_ index: Int) -> CaptionValueCellViewModel? {
        guard !cellViewModels.isEmpty, index < cellViewModels.count else { return nil }
        return cellViewModels[index]
    }
}
