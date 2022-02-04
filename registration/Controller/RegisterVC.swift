//
//  RegisterVC.swift
//  registration
//
//  Created by Mac on 10/9/21.
//  Copyright © 2021 ramy. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var selectPhoto: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserImage()
        addLogInBotton()
        SqliteManager.shared().createTable()
        setGradient()
        imageBtnBorders()
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
    
    private func isValidName(name: String) -> Bool {
        if !name.isEmpty {
            return true
        } else {
            showAlert(message: "Please enter valid name!")
            return false
        }
    }
    
    private func isValidAddress(address: String) -> Bool {
        if !address.isEmpty {
            return true
        } else {
            showAlert(message: "Please enter valid address!")
            return false
        }
    }
    
    private func isEnteredImage(image: UIImage) -> Bool {
        if image == UIImage(named: "user") {
            self.showAlert(message: "Please enter valid photo")
            return false
        }
        return true
    }
    
    private func setUserImage() {
        imageView.image = UIImage(named: "user")
    }
    
    private func validFields() -> Bool {
        if let name = nameTextField.text, isValidName(name: name),
            let address = addressTextField.text, isValidAddress(address: address),
            let email = emailTextField.text, isValidEmail(email: email),
            let password = passwordTextField.text, isValidPassword(password: password),
            let image = imageView.image, isEnteredImage(image: image) {
            let user: User = User(name: name, email: email, password: password, address: address, image: image.jpegData(compressionQuality: 1))
            SqliteManager.shared().insertUser(user: user)
            return true
        }
        return false
    }
    
    @objc private func goToLogInScreen() {
        let sb = UIStoryboard(name: StoryBroard.main, bundle: nil)
        let logInVC = sb.instantiateViewController(withIdentifier: StoryBroard.LogInVC) as! LogInVC
        if validFields() {
            self.navigationController?.pushViewController(logInVC, animated: true)
        }
    }
    
    private func orLoginBtn() {
        let sb = UIStoryboard(name: StoryBroard.main, bundle: nil)
        let logInVC = sb.instantiateViewController(withIdentifier: StoryBroard.LogInVC) as! LogInVC
        self.navigationController?.pushViewController(logInVC, animated: true)
    }
    
    private func addLogInBotton() {
        navigationItem.title = Title.regTitle
    }
    
    private func imageBtnBorders() {
        selectPhoto.layer.borderWidth = 1
        selectPhoto.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBAction func addressBtnTapped(_ sender: Any) {
        let sb = UIStoryboard(name: StoryBroard.main, bundle: nil)
        let mapVC = sb.instantiateViewController(withIdentifier: StoryBroard.MapVC) as! MapVC
        mapVC.delegate = self
        self.present(mapVC, animated: true, completion: nil)
    }
    
    @IBAction func selectImageBtnTapped(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func regidterBtnTapped(_ sender: UIButton) {
        if validFields() {
            goToLogInScreen()
        }
        else {
            showAlert(message: "Please enter valid data")
        }
    }
    
    @IBAction func logInBtnTapped(_ sender: UIButton) {
        orLoginBtn()
    }
}

extension RegisterVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate, sendingAddressDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func sendAdress(to address: String) {
        addressTextField.text = address
    }
}

