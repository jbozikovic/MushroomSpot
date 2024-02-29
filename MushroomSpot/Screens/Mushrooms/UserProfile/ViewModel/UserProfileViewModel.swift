//
//  UserProfileViewModel.swift
//  MushroomSpot
//
//  Created by Jurica Bozikovic on 28.02.2024..
//  Copyright © 2024 CocodeLab. All rights reserved.
//

import Foundation
import Combine

//  MARK: - UserProfileViewModelSection
enum UserProfileViewModelSection: Int, CaseIterable {
    case id
    case username
    case firstName
    case lastName
                
    var title: String {
        switch self {
        case .id:
            return AppStrings.id.localized
        case .username:
            return AppStrings.username.localized
        case .firstName:
            return AppStrings.firstName.localized
        case .lastName:
            return AppStrings.lastName.localized
        }
    }
}


//  MARK: - UserProfileViewModel
class UserProfileViewModel: Loadable {
    private(set) var headerViewModel: MushroomDetailsHeaderViewModel?
    private var cellViewModels: [CaptionValueCellViewModel] = []
    private let repository: UserRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    private var user: User? = nil {
        didSet {
            prepareDataAndReload()
        }
    }
        
    // MARK: - Publishers
    lazy var shouldReloadData = PassthroughSubject<Void, Never>()
    lazy var failure = PassthroughSubject<Error, Never>()
    //  MARK: - Loadable
    var isLoading: Bool = false
    var loadingStatusUpdated: PassthroughSubject<Bool, Never> = PassthroughSubject<Bool, Never>()
    
    init(repository: UserRepositoryProtocol) {
        self.repository = repository
        loadData()
    }
    
    //  MARK: - Load data
    func loadData() {
        updateLoadingStatus()
        repository.getUser()
            .sink { [weak self] completion in
                guard let weakSelf = self else { return }
                weakSelf.updateLoadingStatus()
                switch completion {
                case .failure(let error):
                    weakSelf.failure.send(error)
                case .finished:
                    Utility.printIfDebug(string: "Received completion: \(completion).")
                }
            } receiveValue: { [weak self] response in
                guard let weakSelf = self else { return }
                weakSelf.updateLoadingStatus()
                weakSelf.user = response.user
            }.store(in: &cancellables)
    }
    
    
    //  MARK: - Prepare data and reload view
    private func prepareDataAndReload() {
        guard let user = user else { return failure.send(AppError.genericError) }
        cellViewModels = [
            CaptionValueCellViewModel(caption: UserProfileViewModelSection.id.title, value: user.id),
            CaptionValueCellViewModel(caption: UserProfileViewModelSection.username.title, value: user.username),
            CaptionValueCellViewModel(caption: UserProfileViewModelSection.firstName.title, value: user.firstName),
            CaptionValueCellViewModel(caption: UserProfileViewModelSection.lastName.title, value: user.lastName)
        ]
        shouldReloadData.send()
    }
}


//  MARK: - Number of items,views visibility...
extension UserProfileViewModel {
    var title: String {
        return AppStrings.details.localized
    }
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
