//
//  ReturnedTweet.swift
//  brain-marks
//
//  Created by Mikaela Caron on 5/1/21.
//

import Foundation

class ReturnedTweet: Codable {
    
    init(id: String, text: String, timeStamp: String, authorName: String, authorUsername: String, profileImageURL: String, userVerified: Bool, photosUrl: [String], quoteTweet: ReturnedTweet? = nil) {
        self.id = id
        self.text = text
        self.timeStamp = timeStamp
        self.authorName = authorName
        self.authorUsername = authorUsername
        self.profileImageURL = profileImageURL
        self.userVerified = userVerified
        self.photosUrl = photosUrl
        self.quoteTweet = quoteTweet
    }
    
    let id: String
    let text: String
    let timeStamp: String
    
    let authorName: String
    let authorUsername: String
    let profileImageURL: String
    let userVerified: Bool
    
    let photosUrl : [String]
    let quoteTweet: ReturnedTweet?
}
