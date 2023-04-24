// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "83f5e8fef9078cee9109bd41d707e221"
    
    /// Register the `AWSTweet` and `AWSCategory` models
    /// - Parameter registry: <#registry description#>
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: AWSTweet.self)
    ModelRegistry.register(modelType: AWSCategory.self)
  }
}
