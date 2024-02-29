//
//  LoginViewController.swift
//  MushroomSpot
//
//  Created by Jurica Bozikovic on 28.02.2024..
//  Copyright © 2024 CocodeLab. All rights reserved.
//

import UIKit
import Combine

// MARK: - LoginViewController
class LoginViewController: UIViewController, ViewControllerProtocol {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: PasswordTextField!
    @IBOutlet weak var confirmButton: UIButton!
    
    private var viewModel: LoginViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: LoginViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        setupPublishers()
        setupGUI()
        handleKeyboardNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    //  MARK: - Handle touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    //  MARK: - Setup UI
    func setupGUI() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        setupNavigationBar()
        setupNavigationBarItems()
        setupBackground()
        Utility.setupLabel(titleLabel, font: AppUI.navigationBarLargeTitleFont, textColor: AppUI.titleFontColor, textAlignment: .center, text: AppStrings.login.localized)
        setupTextField(textfield: emailTextField, placeholderText: AppStrings.email.localized, text: self.viewModel.email)
        emailTextField.textContentType = .emailAddress
        setupTextField(textfield: passwordTextField, placeholderText: AppStrings.password.localized, text: self.viewModel.password)
        setupConfirmButton()
    }
    
    private func setupTextField(textfield: UITextField, placeholderText: String, text: String) {
        textfield.clearButtonMode = .never
        textfield.delegate = self
        textfield.addBottomBorder(color: UIColor.black.cgColor)
        textfield.setPadding(left: LoginConstants.textFieldPadding)
        textfield.text = text
    }
    
    private func setupConfirmButton() {
        confirmButton.setTitle(AppStrings.login.localized, for: .normal)
        confirmButton.layer.cornerRadius = AppUI.cornerRadius
        confirmButton.setTitleColor(.white, for: .normal)
    }
    
    @IBAction func confirmButtonTap(_ sender: UIButton) {
        viewModel.login()
    }
        
    //  MARK: - Keyboard notifications
    private func handleKeyboardNotifications() {
        KeyboardObserver().keyboardHeightPublisher
            .sink(receiveValue: { [weak self] value in
                guard let weakSelf = self else { return }
                weakSelf.view.frame.origin.y = value > 0 ? (-value / 3) : value
            }).store(in: &cancellables)
    }
    
    //  MARK: - Publishers
    func setupPublishers() {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: emailTextField)
            .map { ($0.object as! UITextField).text ?? "" }
            .assign(to: \.email, on: viewModel)
            .store(in: &cancellables)

        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: passwordTextField)
            .map { ($0.object as! UITextField).text ?? "" }
            .assign(to: \.password, on: viewModel)
            .store(in: &cancellables)
                
        viewModel.isSubmitEnabled
            .assign(to: \.isEnabled, on: confirmButton)
            .store(in: &cancellables)
                
        confirmButton.publisher(for: \.isEnabled)
            .sink { enabled in
                self.confirmButton.backgroundColor = enabled ? AppUI.buttonColor : .gray
            }.store(in: &cancellables)

    }
}

//  MARK: - View model
extension LoginViewController {
    private func setupViewModel() {
        handleViewModelLoginFailedPublisher()
        handleLoadingStatusUpdated()
    }
    
    private func handleViewModelLoginFailedPublisher() {
        viewModel.loginFailed.sink { [weak self] (error) in
            guard let weakSelf = self else { return }
            weakSelf.handleError(error)
        }.store(in: &cancellables)
    }
    
    func handleLoadingStatusUpdated() {
        self.viewModel.loadingStatusUpdated.sink { [weak self] (isLoading) in
            guard let weakSelf = self else { return }
            isLoading ? weakSelf.showActivityIndicator() : weakSelf.hideActivityIndicator()
        }.store(in: &cancellables)
    }
}

//  MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
