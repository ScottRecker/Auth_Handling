//
//  RegisterViewController.swift
//  iOS Auth Handling UIKit
//
//  Created by Scott Recker on 7/4/24.
//

import UIKit

protocol RegisterNavDelegate: AnyObject {
    func onRegistrationComplete()
    func onLoginTapped()
}

class RegisterViewController: UIViewController {
    private lazy var emailTextField = UITextField.makeEmailField(delegate: self)
    private lazy var passwordTextField = UITextField.makePasswordField(delegate: self)
    private lazy var confirmPasswordTextField = UITextField.makePasswordField(placeholder: "Confirm password", delegate: self)
    private lazy var registerButton = UIButton.makeButton(title: "Register", target: self, action: #selector(self.onRegisterTapped))
    private lazy var loginButton = UIButton.makeButton(title: "Login", target: self, action: #selector(self.onLoginTapped))

    weak var navDelegate: RegisterNavDelegate?
    private let viewModel: ViewModel

    required init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Lifecycle
extension RegisterViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

// MARK: - Setup Views/Configuration
private extension RegisterViewController {
    func setupViews() {
        title = "Register"
        view.backgroundColor = .white

        emailTextField
            .addTo(view)
            .centerOn(view)
            .setDefaultFieldSize(superview: view)

        passwordTextField
            .addTo(view)
            .centerXOn(view)
            .pinTop(toAnchor: emailTextField.bottomAnchor, constant: 10)
            .setDefaultFieldSize(superview: view)

        confirmPasswordTextField
            .addTo(view)
            .centerXOn(view)
            .pinTop(toAnchor: passwordTextField.bottomAnchor, constant: 10)
            .setDefaultFieldSize(superview: view)

        registerButton
            .addTo(view)
            .centerXOn(view)
            .pinTop(toAnchor: confirmPasswordTextField.bottomAnchor, constant: 10)
            .setDefaultFieldSize(superview: view)

        loginButton
            .addTo(view)
            .centerXOn(view)
            .pinBottom(toAnchor: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
            .setDefaultFieldSize(superview: view)
    }
}

// MARK: - Actions
extension RegisterViewController {
    @objc func onRegisterTapped() {
        viewModel.email = emailTextField.text
        viewModel.password = passwordTextField.text
        viewModel.confirmPassword = confirmPasswordTextField.text

        Task {
            do {
                try await viewModel.submitRegister()
                await MainActor.run { [weak self] in
                    self?.showOkAlert(title:"Registered", message: "Activation email sent to \(self?.viewModel.email ?? "Unknown")") { 
                        self?.navDelegate?.onRegistrationComplete()
                    }
                }
            } catch {
                await MainActor.run { [weak self] in
                    self?.showOkAlert(title:"Error", message: error.localizedDescription)
                }
            }
        }
    }
    @objc func onLoginTapped() {
        navDelegate?.onLoginTapped()
    }
}

// MARK: - UITextFieldDelegate
extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            confirmPasswordTextField.becomeFirstResponder()
        } else {
            view.endEditing(true)
        }

        return false
    }
}

#Preview {
    RegisterViewController(viewModel: .init(networkHandler: .init()))
}
