//
//  UITextView+Extensions.swift
//  iOS Auth Handling UIKit
//
//  Created by Scott Recker on 7/4/24.
//

import UIKit

extension UITextView {

    static func makeTextView(text: String? = nil) -> UITextView {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.font = .systemFont(ofSize: 14)
        view.textAlignment = .center
        return view
    }
}
