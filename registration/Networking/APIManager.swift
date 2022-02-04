//
//  APIManager.swift
//  registration
//
//  Created by Mac on 11/26/21.
//  Copyright © 2021 ramy. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    
    static func loadMediaArray(term: String, media: String, complition: @escaping(_ error: Error?, _ mediaArr: [Media]?) -> Void) {
        let param = ["term": term,
                     "media": media]
        AF.request("https://itunes.apple.com/search", method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).response {
            response in
            if let error = response.error {
                print(error.localizedDescription)
                complition(error, nil)
            }
            
            if let data = response.data {
                do {
                    let mediaArray = try JSONDecoder().decode(MediaResponse.self, from: data).results
                    complition(nil, mediaArray)
                } catch let error {
                    print(error.localizedDescription)
                    complition(error, nil)
                }
            }
        }
    }
}
