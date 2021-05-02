// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "b768468ae9fccc6dcfccd32cbfcc1cc4"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: AWSTweet.self)
    ModelRegistry.register(modelType: AWSCategory.self)
  }
}