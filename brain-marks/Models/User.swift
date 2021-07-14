//
//  User.swift
//  brain-marks
//
//  Created by Mikaela Caron on 4/20/21.
//

import Foundation

// swiftlint:disable identifier_name

struct User: Codable {
    let id: String
    let name: String
    let username: String
    let profile_image_url: String
}
