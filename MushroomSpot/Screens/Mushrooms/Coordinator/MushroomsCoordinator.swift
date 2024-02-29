//
//  MushroomsCoordinator.swift
//  MushroomSpot
//
//  Created by Jurica Bozikovic on 27.02.2024..
//  Copyright © 2024 CocodeLab. All rights reserved.
//

import UIKit
import Combine

class MushroomsCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var presenter: UINavigationController
    var viewModel: MushroomsViewModel?
    var repository: MushroomsRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
        
    private let networkLayerService: NetworkLayerProtocol = NetworkLayerService()
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        childCoordinators = []
        let apiService = MushroomsAPIService(networkLayerService: networkLayerService)
        repository = MushroomsRepository(apiService: apiService)
    }
    
    func start() {
        setupViewModel()
        navigateToMushroomsListViewController()
    }
}

//  MARK: - View model
private extension MushroomsCoordinator {
    func setupViewModel() {
        viewModel = MushroomsViewModel(repository: repository)
        handleDidTapListItemPublisher()
        handleDidTapUserProfilePublisher()
    }
    
    func handleDidTapListItemPublisher() {
        viewModel?.didTapListItem.sink { [weak self] (item) in
            guard let weakSelf = self else { return }
            weakSelf.navigateToDetailsView(mushroom: item)
        }.store(in: &cancellables)
    }
    
    func handleDidTapUserProfilePublisher() {
        viewModel?.didTapProfileButton.sink { [weak self] _ in
            guard let weakSelf = self else { return }
            weakSelf.presentUserProfileView()
        }.store(in: &cancellables)
    }
}

//  MARK: - Mushrooms list
private extension MushroomsCoordinator {
    private func navigateToMushroomsListViewController() {
        guard let vm = viewModel else { return }
        let vc = MushroomsViewController(viewModel: vm)
        presenter.pushViewController(vc, animated: true)
    }
}

//  MARK: - Mushrooms details
private extension MushroomsCoordinator {
    func navigateToDetailsView(mushroom: Mushroom) {
        let vc = MushroomDetailsViewController(viewModel: MushroomDetailsViewModel(mushroom: mushroom))        
        presenter.pushViewController(vc, animated: true)
    }
}

//  MARK: - User profile
private extension MushroomsCoordinator {
    func presentUserProfileView() {
        let apiService = UserAPIService(networkLayerService: networkLayerService)
        let viewModel = UserProfileViewModel(repository: UserRepository(apiService: apiService))
        let vc = UserProfileViewController(viewModel: viewModel)        
        presenter.present(vc, animated: true)
    }
}


