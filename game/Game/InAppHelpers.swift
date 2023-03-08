//
//  InAppHelpers.swift
//  MayanDiamonds
//
//  Created by 1 on 22.03.2022.
//

import UIKit

extension UIColor {
    static var normlabel: UIColor {
        if Settings.shared.darkMode == .dark {
            return .white
        } else {
            return .black
        }
    }
}

extension UIView {
    func fillSuperView() {
        guard let superview = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
        ])
    }
    
    func fillSuperViewsSafeArea() {
        guard let superview = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor),
            self.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
        ])
    }
    
    func ancherToSuperviewsCenter() {
        guard let superview = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: superview.centerYAnchor),
        ])
    }
    
    func makeSqr() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalTo: self.heightAnchor),
        ])
    }
}
