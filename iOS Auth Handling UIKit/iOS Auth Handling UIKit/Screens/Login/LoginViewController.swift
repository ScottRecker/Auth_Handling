//
//  LoginViewController.swift
//  iOS Auth Handling UIKit
//
//  Created by Scott Recker on 7/3/24.
//

import UIKit

class LoginViewController: UIViewController {
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
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello World!"
        view.backgroundColor = .white

        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 50.0),
            label.widthAnchor.constraint(equalToConstant: 100.0),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

#Preview {
    LoginViewController()
}
