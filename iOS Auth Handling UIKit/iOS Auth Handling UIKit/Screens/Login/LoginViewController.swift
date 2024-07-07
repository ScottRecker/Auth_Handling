//
//  LoginViewController.swift
//  iOS Auth Handling UIKit
//
//  Created by Scott Recker on 7/3/24.
//

import UIKit

protocol LoginNavDelegate: AnyObject {
    func onRegisterTapped()
    func onLoginSuccessful()
}

class LoginViewController: UIViewController {
    private lazy var emailTextField = UITextField.makeEmailField(delegate: self)
    private lazy var passwordTextField = UITextField.makePasswordField(delegate: self)
    private lazy var submitButton = UIButton.makeButton(title: "Submit", target: self, action: #selector(self.onSubmitTapped))
    private lazy var registerButton = UIButton.makeButton(title: "Register", target: self, action: #selector(self.onRegisterTapped))

    weak var navDelegate: LoginNavDelegate?
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
extension LoginViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

// MARK: - View Setup/Configuration
private extension LoginViewController {
    func setupViews() {
        title = "Login"
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

        submitButton
            .addTo(view)
            .centerXOn(view)
            .pinTop(toAnchor: passwordTextField.bottomAnchor, constant: 10)

        registerButton
            .addTo(view)
            .centerXOn(view)
            .pinBottom(toAnchor: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
    }
}

// MARK: - Actions
extension LoginViewController {

    @objc func onSubmitTapped() {
        viewModel.email = emailTextField.text
        viewModel.password = passwordTextField.text

        Task {
            do {
                try await viewModel.submitLogin()
                await MainActor.run { [weak self] in
                    self?.navDelegate?.onLoginSuccessful()
                }
            } catch {
                await MainActor.run { [weak self] in
                    self?.showOkAlert(title:"Error", message: error.localizedDescription)
                }
            }
        }
    }

    @objc func onRegisterTapped() { 
        navDelegate?.onRegisterTapped()
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            view.endEditing(true)
        }

        return false
    }
}

#Preview {
    LoginViewController(viewModel: .init(networkHandler: .init(), tokenStorage: .init()))
}
