//
//  LoginCoordinator.swift
//  MushroomSpot
//
//  Created by Jurica Bozikovic on 28.02.2024..
//  Copyright © 2024 CocodeLab. All rights reserved.
//

import UIKit
import Combine

//  MARK: - LoginCoordinator
class LoginCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    var presenter: UINavigationController
    private var viewModel: LoginViewModel?
    private var cancellables = [AnyCancellable]()
    
    lazy var loginCoordinatorDidFinish = PassthroughSubject<Void, Never>()
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        childCoordinators = []
    }

    func start() {
        setupViewModel()
        navigateToLoginViewController()
    }
    
    private func stopLoginCoordinator() {
        loginCoordinatorDidFinish.send()
    }
}

//  MARK: - View model
private extension LoginCoordinator {
    func setupViewModel() {
        viewModel = LoginViewModel(authService: authService)
        handleDidFinishLoginPublisher()
    }
    
    func handleDidFinishLoginPublisher() {
        guard let vm = viewModel else { return }
        vm.didFinishLogin.sink { [weak self] (_) in
            guard let weakSelf = self else { return }
            weakSelf.stopLoginCoordinator()
        }.store(in: &cancellables)
    }
}

//  MARK: - Login view
private extension LoginCoordinator {
    func navigateToLoginViewController() {
        guard let vm = self.viewModel else { return }
        let vc = LoginViewController(viewModel: vm)
        presenter.pushViewController(vc, animated: true)
    }
}

//  MARK: - Auth and network layer services
private extension LoginCoordinator {
    var authService: AuthService {
        AuthService(networkLayerService: NetworkLayerService(), keychainService: KeychainService())
    }
}

