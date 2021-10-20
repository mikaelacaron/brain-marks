// swiftlint:disable all
import Amplify
import Foundation

public struct AWSTweet: Model {
  public let id: String
  public var tweetID: String
  public var text: String?
  public var timeStamp: String?
  public var authorName: String?
  public var authorUsername: String?
  public var profileImageURL: String?
  public var category: AWSCategory?
  public var userVerified: Bool?
  
  public init(id: String = UUID().uuidString,
      tweetID: String,
      text: String? = nil,
      timeStamp: String? = nil,
      authorName: String? = nil,
      authorUsername: String? = nil,
      profileImageURL: String? = nil,
      category: AWSCategory? = nil,
      userVerified: Bool? = nil) {
      self.id = id
      self.tweetID = tweetID
      self.text = text
      self.timeStamp = timeStamp
      self.authorName = authorName
      self.authorUsername = authorUsername
      self.profileImageURL = profileImageURL
      self.category = category
      self.userVerified = userVerified
  }
}