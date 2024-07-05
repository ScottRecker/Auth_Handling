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
    private lazy var emailTextField = UITextField.makeEmailField()
    private lazy var passwordTextField = UITextField.makePasswordField()
    private lazy var confirmPasswordTextField = UITextField.makePasswordField(placeholder: "Confirm password")
    private lazy var registerButton = UIButton.makeButton(title: "Register", target: self, action: #selector(self.onRegisterTapped))
    private lazy var loginButton = UIButton.makeButton(title: "Login", target: self, action: #selector(self.onLoginTapped))

    weak var navDelegate: RegisterNavDelegate?
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
        navDelegate?.onRegistrationComplete()
    }
    @objc func onLoginTapped() {
        navDelegate?.onLoginTapped()
    }
}


#Preview {
    RegisterViewController()
}
