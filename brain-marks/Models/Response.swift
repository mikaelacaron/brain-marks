//
//  Response.swift
//  brain-marks
//
//  Created by Mikaela Caron on 4/20/21.
//

import Foundation

struct Response: Codable {
    let data: [Tweet]
    let includes: Includes
}
