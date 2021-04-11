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

struct ResponseModel: Codable {
    let data:TweetModel
}
