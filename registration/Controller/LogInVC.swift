//
//  LogIn.swift
//  registration
//
//  Created by Mac on 10/9/21.
//  Copyright © 2021 ramy. All rights reserved.
//

import UIKit
class LogInVC: UIViewController {
    
    @IBOutlet weak var emaiTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaultManager.shared().setIsLoggedIn(value: false)
        self.titleBarBtn()
        cancelNavItem()
        setGradient()
    }
    
    private func isValidEmail(email: String) -> Bool {
        if !email.trimmed.isEmpty {
            if Validator.shared().isValidEmail(email: email) {
                return true
            } else {
                showAlert(message: "Please enter valid email")
                return false
            }
        } else {
            showAlert(message: "Please enter email")
        }
        return false
    }
    
    private func isValidPassword(password: String) -> Bool {
        if !password.isEmpty {
            if Validator.shared().isValidPasseord(password: password) {
                return true
            } else {
                showAlert(message: "Please enter valid password with 8 characters at least 1 Alphabet and 1 Number:")
                return false
            }
        } else {
            showAlert(message: "Please enter valid password")
            return false
        }
    }
    
    private func validFields() -> Bool {
        if let email = emaiTextField.text, isValidEmail(email: email),
            let password = passwordTextField.text, isValidPassword(password: password) {
            if let user = SqliteManager.shared().getUserWith(email: email) {
                if user.password == password {
                    UserDefaultManager.shared().setUserEmail(email: email)
                    return true
                }
                self.showAlert(message: "password not correct")
            }
            self.showAlert(message: "email not found")
        } else {
            self.showAlert(message: "enter valid data")
        }
        return false
    }
    
    private func goToMoviesScreen() {
        let sb = UIStoryboard(name: StoryBroard.main, bundle: nil)
        let moviesVC = sb.instantiateViewController(identifier: StoryBroard.MoviesVC) as!
        MoviesVC
        self.navigationController?.pushViewController(moviesVC, animated: true)
    }
    
    @objc private func goToRegisterScreen() {
        let sb = UIStoryboard(name: StoryBroard.main, bundle: nil)
        let registerVC = sb.instantiateViewController(identifier: StoryBroard.RegisterVC) as!
        RegisterVC
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    private func titleBarBtn() {
        navigationItem.title = Title.logTitle
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: Title.regTitle, style: .plain, target: self, action: #selector(goToRegisterScreen))
    }
    
    private func cancelNavItem() {
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        if validFields() {
            goToMoviesScreen()
        } else {
            showAlert(message: "Please enter valid data")
        }
    }
}
