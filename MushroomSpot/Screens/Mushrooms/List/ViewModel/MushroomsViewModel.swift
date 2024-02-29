//
//  MushroomsViewModel.swift
//  MushroomSpot
//
//  Created by Jurica Bozikovic on 28.02.2024..
//  Copyright © 2024 CocodeLab. All rights reserved.
//

import Foundation
import Combine

//  MARK: - MushroomsViewModel
class MushroomsViewModel: Loadable {
    private var mushrooms: [Mushroom] = [] {
        didSet{
            self.prepareDataAndReload()
        }
    }
    private var cellViewModels: [MushroomCellViewModel] = []
    private let repository: MushroomsRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
        
    //  MARK: - Loadable
    var isLoading: Bool = false
    var loadingStatusUpdated: PassthroughSubject<Bool, Never> = PassthroughSubject<Bool, Never>()
            
    // MARK: - Publishers
    lazy var didTapListItem = PassthroughSubject<Mushroom, Never>()
    lazy var failure = PassthroughSubject<Error, Never>()
    lazy var shouldReloadData = PassthroughSubject<Void, Never>()
    lazy var didTapProfileButton = PassthroughSubject<Void, Never>()
                    
    init(repository: MushroomsRepositoryProtocol) {
        self.repository = repository
        loadData()
    }
            
    //  MARK: - Load data
    func loadData() {
        updateLoadingStatus()
        repository.getMushrooms()
            .sink(receiveCompletion: { [weak self] completion in
                guard let weakSelf = self else { return }
                weakSelf.updateLoadingStatus()
                switch completion {
                case .failure(let error):
                    weakSelf.failure.send(error)
                case .finished:
                    Utility.printIfDebug(string: "Received completion: \(completion).")
                }
            }, receiveValue: { [weak self] response in
                guard let weakSelf = self else { return }
                weakSelf.mushrooms = response.mushrooms
            }).store(in: &cancellables)        
    }
            
    //  MARK: - Prepare view models (for cells)
    private func prepareDataAndReload() {
        cellViewModels = []
        cellViewModels.append(contentsOf: mushrooms.map { MushroomCellViewModel(mushroom: $0) })
        shouldReloadData.send()
    }
}

//  MARK: - Number of items,views visibility...
extension MushroomsViewModel {
    var numberOfItems: Int {
        return cellViewModels.count
    }
    var numberOfSections: Int {
        return Constants.defaultNumberOfSections
    }
    var hasData: Bool {
        numberOfItems > 0
    }
        
    func getItemAtIndex(_ index: Int) -> MushroomCellViewModel? {
        guard !cellViewModels.isEmpty, index < cellViewModels.count else { return nil }
        return cellViewModels[index]
    }

    func userSelectedRow(index: Int) {
        guard let vm = getItemAtIndex(index) else { return }
        didTapListItem.send(vm.mushroom)
    }
}

