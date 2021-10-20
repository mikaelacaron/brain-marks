// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "71ebbcb0a632eb531a6dc01dc4c77f27"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: AWSTweet.self)
    ModelRegistry.register(modelType: AWSCategory.self)
  }
}
