// swiftlint:disable all
import Amplify
import Foundation

extension AWSCategory {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case name
    case imageName
    case tweets
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let aWSCategory = AWSCategory.keys
    
    model.pluralName = "AWSCategories"
    
    model.fields(
      .id(),
      .field(aWSCategory.name, is: .required, ofType: .string),
      .field(aWSCategory.imageName, is: .optional, ofType: .string),
      .hasMany(aWSCategory.tweets, is: .optional, ofType: AWSTweet.self, associatedWith: AWSTweet.keys.category)
    )
    }
}