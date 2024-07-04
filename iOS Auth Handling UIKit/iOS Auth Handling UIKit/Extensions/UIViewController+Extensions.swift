//
//  UIViewController+Extensions.swift
//  iOS Auth Handling UIKit
//
//  Created by Scott Recker on 7/4/24.
//

import UIKit

extension UIViewController {

    func showOkAlert(title: String?, message: String? = nil, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            completion?()
        }
        alert.addAction(okAction)

        present(alert, animated: true)
    }
}
