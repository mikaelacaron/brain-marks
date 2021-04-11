// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "2e2f9f76f94d0d76a69b2e3cdf98ddea"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: AWSTweet.self)
    ModelRegistry.register(modelType: AWSCategory.self)
  }
}