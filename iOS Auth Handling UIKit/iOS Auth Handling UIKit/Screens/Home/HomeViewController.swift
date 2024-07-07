//
//  HomeViewController.swift
//  iOS Auth Handling UIKit
//
//  Created by Scott Recker on 7/4/24.
//

import Combine
import UIKit

protocol HomeNavDelegate: AnyObject {
    func onLogoutTapped()
}

class HomeViewController: UIViewController {
    private lazy var infoText = UITextView.makeTextView()
    private lazy var fetchDataButton = UIButton.makeButton(title: "Fetch Secure Data", target: self, action: #selector(onFetchTapped))
    private lazy var resetButton = UIButton.makeButton(title: "Reset Text", target: self, action: #selector(onResetTextTapped))
    private lazy var logoutButton = UIButton.makeButton(title: "Logout", target: self, action: #selector(onLogoutTapped))
    
    private var cancellables = Set<AnyCancellable>()

    weak var navDelegate: HomeNavDelegate?
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
extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupObservers()
    }
}

// MARK: - View setup/configuration
private extension HomeViewController {
    func setupViews() {
        title = "Home"
        view.backgroundColor = .white

        infoText
            .addTo(view)
            .centerOn(view)
            .setDefaultFieldSize(superview: view)
        infoText.text = "Tap Fetch Button to fetch secured data"

        fetchDataButton
            .addTo(view)
            .centerXOn(view)
            .pinTop(toAnchor: infoText.bottomAnchor, constant: 10)

        resetButton
            .addTo(view)
            .centerXOn(view)
            .pinTop(toAnchor: fetchDataButton.bottomAnchor, constant: 10)
        
        logoutButton
            .addTo(view)
            .centerXOn(view)
            .pinBottom(toAnchor: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
    }
}

// MARK: - Actions
private extension HomeViewController {
    
    @objc func onFetchTapped() {
        Task {
            do {
                try await viewModel.fetchSecureData()
            } catch {
                await MainActor.run { [weak self] in
                    self?.showOkAlert(title:"Error", message: error.localizedDescription)
                }
            }
        }
    }

    @objc func onResetTextTapped() {
        viewModel.resetInfoText()
    }

    @objc func onLogoutTapped() {
        navDelegate?.onLogoutTapped()
    }
}

// MARK: - Observers
private extension HomeViewController {
    func setupObservers() {
        viewModel.$infoText
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newText in
                self?.infoText.text = newText
            }.store(in: &cancellables)
    }
}

// MARK: - Actions

#Preview {
    HomeViewController(viewModel: .init(networkHandler: .init(), tokenStorage: .init()))
}
