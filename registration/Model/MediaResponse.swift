//
//  MediaResponse.swift
//  registration
//
//  Created by Mac on 11/26/21.
//  Copyright © 2021 ramy. All rights reserved.
//

import Foundation

struct MediaResponse: Decodable {
    var resultCount: Int
    var results: [Media]
}
