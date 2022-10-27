//
//  Tweet.swift
//  brain-marks
//
//  Created by PRABALJIT WALIA     on 11/04/21.
//

import Foundation

enum ReferencedTweetType: String, Codable {
    case replied_to
    case quoted
}

struct ReferencedTweet: Codable {
    let type: ReferencedTweetType
    let id: String
}

struct Tweet: Codable {
    let id: String
    let text: String
    let created_at: String
    let referenced_tweets: [ReferencedTweet]
}
