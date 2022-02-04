//
//  Media.swift
//  registration
//
//  Created by Mac on 11/26/21.
//  Copyright © 2021 ramy. All rights reserved.
//

import Foundation

struct Media: Codable {
    
    var artistName: String?
    var trailer: String?
    var poster: String!
    var longDescription: String?
    var trackName: String?
    
    enum CodingKeys: String, CodingKey {
        case artistName, longDescription, trackName
        case trailer = "previewUrl"
        case poster = "artworkUrl100"
    }
}
