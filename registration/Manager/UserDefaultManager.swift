//
//  UserDefaultManager.swift
//  registration
//
//  Created by Mac on 10/31/21.
//  Copyright © 2021 ramy. All rights reserved.
//

import Foundation

class UserDefaultManager {
    
    let def = UserDefaults.standard
    static let sharedInstance = UserDefaultManager()
    
    static func shared() -> UserDefaultManager {
        return UserDefaultManager.sharedInstance
    }
    
    func saveUser(user: User) {
        let encoder = JSONEncoder()
        if let encodedUser = try? encoder.encode(user){
            def.set(encodedUser, forKey: "user")
        }
    }
    
    func loadUserData() -> User? {
        if let savedUser = def.object(forKey: "user") as? Data {
            let decoder = JSONDecoder()
            if let decodedUser = try? decoder.decode(User.self, from: savedUser) {
                return decodedUser
            }
        }
        return nil
    }
    
    func setIsLoggedIn(value: Bool) {
        def.set(value, forKey: StoryBroard.isLoggedIn)
    }
    
    func getUserEmail() -> String? {
        if let email = def.string(forKey: "email") {
            return email
        }
        return nil
    }
    
    func setUserEmail(email: String) {
        def.set(email, forKey: "email")
    }
}
