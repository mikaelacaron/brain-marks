//
//  LocalCategoryModel.swift
//  brain-marks
//
//  Created by Susannah Skyer Gupta on 11/4/22.
//

import Foundation

public struct LocalCategory: Codable {
  public let id: String
  public var name: String
  public var imageName: String?
  public var tweets: [LocalTweet]?
  public var categoryThumbnail: String?

  public init(id: String = UUID().uuidString,
              name: String,
              imageName: String? = "folder",
              tweets: [LocalTweet] = []
  ) {
    self.id = id
    self.name = name
    self.imageName = imageName
    self.tweets = tweets
  }
}
