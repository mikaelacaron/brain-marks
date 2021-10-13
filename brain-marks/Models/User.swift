//
//  User.swift
//  brain-marks
//
//  Created by Mikaela Caron on 4/20/21.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let username: String
    let profileImageURL: String
    let verified: Bool
}

extension User {
    enum CodingKeys: String, CodingKey {
        case id, name, username, verified
        case profileImageURL = "profile_image_url"
    }
}
