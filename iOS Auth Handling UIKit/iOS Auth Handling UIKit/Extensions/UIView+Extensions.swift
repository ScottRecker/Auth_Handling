//
//  UIView+Extensions.swift
//  iOS Auth Handling UIKit
//
//  Created by Scott Recker on 7/4/24.
//

import UIKit

// MARK: - AutoLayout Helpers (centering/sizing)
extension UIView {

    @discardableResult
    func addTo(_ view: UIView) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        return self
    }

    @discardableResult
    func centerXOn(_ view: UIView) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        return self
    }

    @discardableResult
    func centerYOn(_ view: UIView) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return self
    }

    @discardableResult
    func centerOn(_ view: UIView) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        return centerXOn(view).centerYOn(view)
    }

    @discardableResult
    func setDefaultFieldSize(superview: UIView) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 40).isActive = true
        widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 0.5).isActive = true
        return self
    }
}

// MARK: - AutoLayout Pinning Edges
extension UIView {
    
    @discardableResult
    func pinTop(toAnchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: toAnchor, constant: constant).isActive = true
        return self
    }

    @discardableResult
    func pinBottom(toAnchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(equalTo: toAnchor, constant: constant).isActive = true
        return self
    }

}
