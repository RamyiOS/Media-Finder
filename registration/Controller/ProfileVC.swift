//
//  ProfileVC.swift
//  registration
//
//  Created by Mac on 10/9/21.
//  Copyright © 2021 ramy. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var emailTextField: UILabel!
    @IBOutlet weak var addressTextField: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getUserData()
        self.setUserData()
        self.addLogoutBotton()
        setGradient()
    }
    
    private func setUserData() {
        emailTextField.text = user.email
        nameTextField.text = user.name
        addressTextField.text = user.address
        userImage.image = UIImage(data: user.image)
    }
    
    @objc func goToLogoutVC() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.openOnLogInScreen()
        }
    }
    
    private func addLogoutBotton() {
        navigationItem.title = Title.profileTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Title.logOutTitle, style: .plain, target: self, action: #selector(goToLogoutVC))
    }
    private func getUserData() {
        if let email = UserDefaultManager.shared().getUserEmail() {
            if let user = SqliteManager.shared().getUserWith(email: email) {
                self.user = user
            }
        }
    }
}

