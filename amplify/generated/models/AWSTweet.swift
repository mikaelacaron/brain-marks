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
  public var photosURL: [String]?
  public var category: AWSCategory?
  public var userVerified: Bool?
  
  public init(id: String = UUID().uuidString,
      tweetID: String,
      text: String? = nil,
      timeStamp: String? = nil,
      authorName: String? = nil,
      authorUsername: String? = nil,
      profileImageURL: String? = nil,
      photosURL: [String]? = [],
      category: AWSCategory? = nil,
      userVerified: Bool? = nil) {
      self.id = id
      self.tweetID = tweetID
      self.text = text
      self.timeStamp = timeStamp
      self.authorName = authorName
      self.authorUsername = authorUsername
      self.profileImageURL = profileImageURL
      self.photosURL = photosURL
      self.category = category
      self.userVerified = userVerified
  }
}

extension AWSTweet {
   static let exampleAWSTweets = [
    AWSTweet(id: "5CA8E5FE-897B-4FF7-92FB-2F2B02770EA7", tweetID: "1576773239132819457", text: Optional("@NutterFi #RingsOfPower unlocked on my iPhone ? Gimme 😍"), timeStamp: Optional("2022-10-03T03:16:49.000Z"), authorName: Optional("yannemal"), authorUsername: Optional("yannemal"), profileImageURL: Optional("https://pbs.twimg.com/profile_images/605843886620045312/-tY5p18X_bigger.png"), photosURL: Optional([]), category: nil, userVerified: Optional(false)),
     
     AWSTweet(id: "9A5E5628-734A-416A-AFE8-256CC6D1A135", tweetID: "1579024778161102848", text: Optional("Learn iOS develop#ment for free:\n\nSwift → https://t.co/1OZPm0dlhv\nUIKit → https://t.co/gXZ2Wo36wI\n#SwiftUI → https://t.co/OihgZ73Gbs\nCombine → https://t.co/2nYyUPzIke\nVapor → https://t.co/HnThkQEsSn\nBackend → @supabase \niOS Newsletter → https://t.co/WpVbWdMvNf"), timeStamp: Optional("2022-10-09T08:23:38.000Z"), authorName: Optional("Mayank Gupta👨‍💻🥑"), authorUsername: Optional("iosmayank"), profileImageURL: Optional("https://pbs.twimg.com/profile_images/1515405040625745920/-qJQzUa5_bigger.jpg"), photosURL: Optional([]), category: nil, userVerified: Optional(false)),
     
     AWSTweet(id: "C477F2CF-3DCB-49F1-B77D-E6ED5528C8F1", tweetID: "1579155290947485696", text: Optional("a few months ago i really started finding interest in computer vision. now i\'ve spent the past few weeks messing with ARKit and RealityKit, and having a lot of fun!\n\na lot of separate \".generatePlane\" ModelEntity\'s + one USDZ file (field goal post) #RealityKit #ARKit #AR #SwiftUI https://t.co/vZ3H0t4bv6"), timeStamp: Optional("2022-10-09T17:02:15.000Z"), authorName: Optional("hunter "), authorUsername: Optional("hntrcodes"), profileImageURL: Optional("https://pbs.twimg.com/profile_images/1577568264175091722/apKZEJrj_bigger.jpg"), photosURL: Optional(["https://pbs.twimg.com/media/FepHGNtWYAIR2BI.jpg"]), category: nil, userVerified: Optional(false)),
     
     AWSTweet(id: "9C9B226D-24B4-45D4-9632-5A604A3E86AB", tweetID: "1569916764326166534", text: Optional("Learn this new background task modifier for SwiftUI in my new article! https://t.co/po8CExQhaY #apple #iOS #coding #Swift #SwiftUI"), timeStamp: Optional("2022-09-14T05:11:38.000Z"), authorName: Optional("Leonardo Pugliese"), authorUsername: Optional("Leo_Pugliese"), profileImageURL: Optional("https://pbs.twimg.com/profile_images/1243079749423038464/t50iTav1_bigger.jpg"), photosURL: Optional([]), category: nil, userVerified: Optional(false)),
    
    AWSTweet(id: "047EF8B3-F2BF-4BAC-9AF5-EC515901ACED", tweetID: "1579740738140897280", text: Optional("I finally reached €4k MRR. 🥳\n\nI switched my apps to subscriptions 2 years ago. Before, I usually made around €1k a month (paid upfront).\n\nNow they pay my bills, and I can focus 100% on growing them even further. 🤗\n\n#buildinpublic https://t.co/o4u9EHAg7I"), timeStamp: Optional("2022-10-11T07:48:36.000Z"), authorName: Optional("Florian Mielke"), authorUsername: Optional("FlorianMielke"), profileImageURL: Optional("https://pbs.twimg.com/profile_images/1509431457634213891/4rokDzVd_bigger.jpg"), photosURL: Optional(["https://pbs.twimg.com/media/FexcLs7WQAUIoKt.jpg"]), category: nil, userVerified: Optional(false))
    
   ]
}
