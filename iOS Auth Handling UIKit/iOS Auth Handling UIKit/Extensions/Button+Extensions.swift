//
//  Button+Extensions.swift
//  iOS Auth Handling UIKit
//
//  Created by Scott Recker on 7/4/24.
//

import UIKit

extension UIButton {

    static func makeButton(title: String, target: Any?, action: Selector) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.blue, for: .normal)
        button.setTitle(title, for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        return button
    }
}
