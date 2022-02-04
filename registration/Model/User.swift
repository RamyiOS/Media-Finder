//
//  user.swift
//  registration
//
//  Created by Mac on 10/9/21.
//  Copyright © 2021 ramy. All rights reserved.
//

import UIKit

struct User: Codable {
    var name: String!
    var email: String!
    var password: String!
    var address: String!
    var image: Data!
    
}

struct codableImage: Codable {
    let imageData: Data?
    func getImage() -> UIImage? {
        if let imageData = self.imageData {
           return UIImage(data: imageData)
        }
        return nil
    }
    init(withImage image: UIImage) {
        self.imageData = image.jpegData(compressionQuality: 1.0)
    }
}
