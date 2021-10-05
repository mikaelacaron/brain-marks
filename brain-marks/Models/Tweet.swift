//
//  Tweet.swift
//  brain-marks
//
//  Created by PRABALJIT WALIA     on 11/04/21.
//

import Foundation

struct Tweet: Codable {
    let id:String
    let text:String
    let createdAt: String
}

extension Tweet {
    enum CodingKeys: String, CodingKey {
        case id, text
        case createdAt = "created_at"
    }
}
