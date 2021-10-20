//
//  ReturnedTweet.swift
//  brain-marks
//
//  Created by Mikaela Caron on 5/1/21.
//

import Foundation

struct ReturnedTweet: Codable {
    let id: String
    let text: String
    let timeStamp: String
    
    let authorName: String
    let authorUsername: String
    let profileImageURL: String
    let userVerified: Bool
}
