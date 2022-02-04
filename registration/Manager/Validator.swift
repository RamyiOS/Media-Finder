//
//  validator.swift
//  registration
//
//  Created by Mac on 10/31/21.
//  Copyright © 2021 ramy. All rights reserved.
//

import Foundation

class Validator {
    
    // singlton
    private static let sharedInstance = Validator()
    
    static func shared() -> Validator {
        return Validator.sharedInstance
    }
    
    func isValidEmail(email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predic = NSPredicate(format: "SELF MATCHES %@", regex)
        let result = predic.evaluate(with: email)
        return result
    }
    
    func isValidPasseord(password: String) -> Bool {
        let regex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let predic = NSPredicate(format: "SELF MATCHES %@", regex)
        let result = predic.evaluate(with: password)
        return result
    }
}
