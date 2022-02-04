//
//  UIViewControllerAlert.swift
//  registration
//
//  Created by Mac on 10/31/21.
//  Copyright © 2021 ramy. All rights reserved.
//

import UIKit


extension UIViewController {
    func showAlert(message: String) {
        let alert = UIAlertController.init(title: "sorry", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showSuccessAlert() {
        let alert = UIAlertController.init(title: "Success", message: "You are logged in Successfully", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


