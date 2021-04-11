//
//  Tweet.swift
//  brain-marks
//
//  Created by PRABALJIT WALIA     on 11/04/21.
//

import Foundation
struct TweetModel: Codable {
    let id:String
    let text:String
    
}

struct UserModel: Codable {
    let id: String
    let name: String
    let username: String
    let profile_image_url: String
}

struct IncludesModel: Codable {
    let users: [UserModel]
}

struct ResponseModel: Codable {
    let data:TweetModel
    let includes: IncludesModel
}
