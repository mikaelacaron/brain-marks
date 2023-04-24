//
//  LocalTweetModel.swift
//  brain-marks
//
//  Created by Susannah Skyer Gupta on 11/4/22.
//

import Foundation

public struct LocalTweet: Codable {
  public let id: String
  public var tweetID: String
  public var text: String?
  public var timeStamp: String?
  public var authorName: String?
  public var authorUsername: String?
  public var profileImageURL: String?
  public var photosURL: [String]?
  public var category: LocalCategory?
  public var userVerified: Bool?
  
  public init(id: String = UUID().uuidString,
              tweetID: String,
              text: String? = nil,
              timeStamp: String? = nil,
              authorName: String? = nil,
              authorUsername: String? = nil,
              profileImageURL: String? = nil,
              photosURL: [String]? = [],
              category: LocalCategory? = nil,
              userVerified: Bool? = nil) {
    self.id = id
    self.tweetID = tweetID
    self.text = text
    self.timeStamp = timeStamp
    self.authorName = authorName
    self.authorUsername = authorUsername
    self.profileImageURL = profileImageURL
    self.photosURL = photosURL
    self.category = category
    self.userVerified = userVerified
  }
}
