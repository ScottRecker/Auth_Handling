//
//  AppNavCoordinator.swift
//  iOS Auth Handling UIKit
//
//  Created by Scott Recker on 7/4/24.
//

import UIKit

class AppNavCoordinator {
    let window: UIWindow
    var presenter: UINavigationController
    
    let tokenStorage = AccessTokenStorage()
    let didCompleteFirstLaunch = "com.recker.authApp"

    init(window: UIWindow) {
        self.window = window
        self.presenter = UINavigationController()

        window.rootViewController = presenter
        window.makeKeyAndVisible()
    }

    func start() {
        let userDefaults = UserDefaults.standard
        if !userDefaults.bool(forKey: didCompleteFirstLaunch) {
            tokenStorage.delete()
            userDefaults.setValue(true, forKey: didCompleteFirstLaunch)
        }

        if tokenStorage.get() != nil {
            showHomeScreen()
        } else {
            showLoginScreen()
        }
    }

    func logout() {
        showLoginScreen()
    }
}

// MARK: - Showing Screens
extension AppNavCoordinator {
    func showHomeScreen() {
        let viewModel = HomeViewController.ViewModel(networkHandler: .init(), tokenStorage: .init())
        let controller = HomeViewController(viewModel: viewModel)
        controller.navDelegate = self
        presenter.setViewControllers([controller], animated: true)
    }

    func showRegistrationScreen() {
        let viewModel = RegisterViewController.ViewModel(networkHandler: .init())
        let controller = RegisterViewController(viewModel: viewModel)
        controller.navDelegate = self
        presenter.pushViewController(controller, animated: true)
    }

    func showLoginScreen() {
        let viewModel = LoginViewController.ViewModel(networkHandler: .init(), tokenStorage: .init())
        let controller = LoginViewController(viewModel: viewModel)
        controller.navDelegate = self
        presenter.setViewControllers([controller], animated: true)
    }
}

// MARK: - HomeNavDelegate
extension AppNavCoordinator: HomeNavDelegate {
    func onLogoutTapped() {
        logout()
    }
}

extension AppNavCoordinator: LoginNavDelegate {
    func onRegisterTapped() {
        showRegistrationScreen()
    }
    
    func onLoginSuccessful() {
        showHomeScreen()
    }
    

}

extension AppNavCoordinator: RegisterNavDelegate {
    func onRegistrationComplete() {
        presenter.popViewController(animated: true)
    }
    
    func onLoginTapped() {
        presenter.popViewController(animated: true)
//        showLoginScreen()
    }
    

}
