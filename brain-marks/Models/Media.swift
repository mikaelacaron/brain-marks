//
//  Media.swift
//  brain-marks
//
//  Created by Fandrian Rhamadiansyah on 26/11/21.
//

import Foundation

struct Media: Codable {
    let id: String
    let type: String
    let url: String
}
/// An extension to `Media` adding `CodingKeys` property
extension Media {
    enum CodingKeys: String, CodingKey {
        case id = "media_key"
        case type = "type"
        case url = "url"
    }
}
