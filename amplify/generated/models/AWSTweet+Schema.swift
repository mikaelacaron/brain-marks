// swiftlint:disable all
import Amplify
import Foundation

extension AWSTweet {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case tweetID
    case text
    case timeStamp
    case authorName
    case authorUsername
    case profileImageURL
    case category
    case userVerified
}
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let aWSTweet = AWSTweet.keys
    
    model.pluralName = "AWSTweets"
    
    model.fields(
      .id(),
      .field(aWSTweet.tweetID, is: .required, ofType: .string),
      .field(aWSTweet.text, is: .optional, ofType: .string),
      .field(aWSTweet.timeStamp, is: .optional, ofType: .string),
      .field(aWSTweet.authorName, is: .optional, ofType: .string),
      .field(aWSTweet.authorUsername, is: .optional, ofType: .string),
      .field(aWSTweet.profileImageURL, is: .optional, ofType: .string),
      .belongsTo(aWSTweet.category, is: .optional, ofType: AWSCategory.self, targetName: "awsTweetCategoryId"),
      .field(aWSTweet.userVerified, is: .optional, ofType: .bool)
    )
    }
}
