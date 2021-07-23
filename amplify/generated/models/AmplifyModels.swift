// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "d5de1438f786aea6bf83e62665ed4581"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: AWSTweet.self)
    ModelRegistry.register(modelType: AWSCategory.self)
  }
}