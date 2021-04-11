//
//  Tweet.swift
//  brain-marks
//
//  Created by PRABALJIT WALIA     on 11/04/21.
//

import Foundation
struct TweetModel:Codable{
    let id:String
    let text:String
//    init(from decoder: Decoder) throws {
//        self.id = 20
//        self.text = "setting up"
//    }
}
struct ResponseModel:Codable{
    let data:TweetModel
}
