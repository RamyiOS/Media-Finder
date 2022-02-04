//
//  UIViewControllerGrediantColor.swift
//  registration
//
//  Created by Mac on 12/3/21.
//  Copyright © 2021 ramy. All rights reserved.
//

import UIKit

extension UIViewController {
    func setGradient() {
        self.view.layoutIfNeeded()
        let gradient = CAGradientLayer()
        gradient.frame = self.view.bounds
        gradient.colors = [UIColor.gradientLight.cgColor, UIColor.gradientDark.cgColor]
        let gradientView = UIView()
        gradientView.layer.insertSublayer(gradient, at: 0)
        gradientView.alpha = 1
        gradientView.frame = self.view.bounds
        view.backgroundColor = .clear
        view.addSubview(gradientView)
        view.sendSubviewToBack(gradientView)
    }
}
