//
//  UITextField+Extensions.swift
//  iOS Auth Handling UIKit
//
//  Created by Scott Recker on 7/4/24.
//

import UIKit

extension UITextField {

    static func makeTextField(text: String? = nil, placeholder: String? = nil) -> UITextField {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.layer.cornerRadius = 5.0
        field.layer.borderWidth = 1.0
        field.clipsToBounds = true
        field.text = text
        field.placeholder = placeholder
        return field
    }

    static func makeEmailField(placeholder: String = "Email", delegate: UITextFieldDelegate? = nil) -> UITextField {
        let field = makeTextField(placeholder: placeholder)
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textContentType = .emailAddress
        field.keyboardType = .emailAddress
        field.autocapitalizationType = .none
        field.delegate = delegate
        return field
    }

    static func makePasswordField(placeholder: String = "Password", delegate: UITextFieldDelegate? = nil) -> UITextField {
        let field = makeTextField(placeholder: placeholder)
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textContentType = .password
        field.autocapitalizationType = .none
        field.isSecureTextEntry = true
        field.delegate = delegate
        return field
    }
}
