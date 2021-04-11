// swiftlint:disable all
import Amplify
import Foundation

public struct AWSTweet: Model {
  public let id: String
  public var tweetID: String
  public var text: String?
  public var category: AWSCategory?
  
  public init(id: String = UUID().uuidString,
      tweetID: String,
      text: String? = nil,
      category: AWSCategory? = nil) {
      self.id = id
      self.tweetID = tweetID
      self.text = text
      self.category = category
  }
}