// swiftlint:disable all
import Amplify
import Foundation

public struct AWSCategory: Model,Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    public static func ==(lhs: AWSCategory, rhs: AWSCategory) -> Bool {
        return lhs.id == rhs.id
    }
    
  public let id: String
  public var name: String
  public var imageName: String?
  public var tweets: List<AWSTweet>?
  
  public init(id: String = UUID().uuidString,
      name: String,
      imageName: String? = nil,
      tweets: List<AWSTweet>? = []) {
      self.id = id
      self.name = name
      self.imageName = imageName
      self.tweets = tweets
  }
}
