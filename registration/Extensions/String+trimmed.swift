//
//  string+trimmed.swift
//  registration
//
//  Created by Mac on 10/31/21.
//  Copyright © 2021 ramy. All rights reserved.
//

import Foundation

extension String {
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
