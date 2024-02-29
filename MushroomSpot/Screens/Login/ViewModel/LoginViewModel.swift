//
//  LoginViewModel.swift
//  MushroomSpot
//
//  Created by Jurica Bozikovic on 28.02.2024..
//  Copyright © 2024 CocodeLab. All rights reserved.
//

import Foundation
import Combine

//  MARK: - LoginValidationErrors
enum LoginValidationErrors {
    case invalidCredentials
    case invalidPassword
    case passwordTooShort
    case genericError
    
    var title: String {
        switch self {
        case .invalidCredentials:
            return AppStrings.invalidCredentials.localized
        default:
            return AppStrings.genericErrorMessage.localized
        }
    }
}

// MARK: - LoginConstants
struct LoginConstants {
    private init() {}

    static let textFieldPadding: CGFloat = 10.0
    static let passwordMinLength: Int = 8
}

//  MARK: - LoginViewModel
class LoginViewModel: Loadable, ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    private let authService: AuthProtocol
    private var cancellables = Set<AnyCancellable>()
        
    //  MARK: - Loadable
    var isLoading: Bool = false
    var loadingStatusUpdated: PassthroughSubject<Bool, Never> = PassthroughSubject<Bool, Never>()
            
    // MARK: - Publishers
    lazy var failure = PassthroughSubject<Error, Never>()
    lazy var didFinishLogin = PassthroughSubject<Void, Never>()
    lazy var loginFailed = PassthroughSubject<Error, Never>()
                        
    init(authService: AuthProtocol) {
        self.authService = authService
    }
                
    func login() {
        updateLoadingStatus()
        authService.loginUser(email: email, password: password)
            .sink(receiveCompletion: { [weak self] completion in
                guard let weakSelf = self else { return }
                weakSelf.updateLoadingStatus()
                switch completion {
                case .failure(let error):
                    weakSelf.loginFailed.send(error)
                case .finished:
                    Utility.printIfDebug(string: "Received completion: \(completion).")
                }
            }, receiveValue: { [weak self] user in
                guard let weakSelf = self else { return }
                weakSelf.didFinishLogin.send()
            }).store(in: &cancellables)
    }
}

//  MARK: - Data validation
extension LoginViewModel {    
    var isValidUsernamePublisher: AnyPublisher<Bool, Never> {
        $email
            .map { $0.isValidEmail }
            .eraseToAnyPublisher()
    }
    var isValidPasswordPublisher: AnyPublisher<Bool, Never> {
        $password
            .map { $0.isValidPassword }
            .eraseToAnyPublisher()
    }
    var isSubmitEnabled: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isValidUsernamePublisher, isValidPasswordPublisher)
            .map { $0 && $1 }
            .eraseToAnyPublisher()
    }
}
