//
//  AWSTweet+Extension.swift
//  brain-marks
//
//  Created by Mikaela Caron on 4/11/21.
//

import Foundation

extension AWSTweet: Identifiable {}
extension AWSTweet: Hashable {
    public static func == (lhs: AWSTweet, rhs: AWSTweet) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// swiftlint:disable line_length
extension AWSTweet {
    static let exampleAWSTweets = [
        AWSTweet(
            id: "5CA8E5FE-897B-4FF7-92FB-2F2B02770EA7",
            tweetID: "1576773239132819457",
            text: "@NutterFi #...RingsOfPower unlocked on my iPhone ? Gimme 😍",
            timeStamp: "2022-10-03T03:16:49.000Z",
            authorName: "yannemal",
            authorUsername: "yannemal",
            profileImageURL: "https://pbs.twimg.com/profile_images/605843886620045312/-tY5p18X_bigger.",
            photosURL: nil,
            category: nil,
            userVerified: false),
        
        AWSTweet(
            id: "9A5E5628-734A-416A-AFE8-256CC6D1A135",
            tweetID: "1579024778161102848",
            text: "Learn iOS #..'; ';'#';' development for free:\n\nSwift → https://t.co/1OZPm0dlhv\nUIKit → https://t.co/gXZ2Wo36wI\n#SwiftUI → https://t.co/OihgZ73Gbs\nCombine → https://t.co/2nYyUPzIke\nVapor → https://t.co/HnThkQEsSn\nBackend → @supabase \niOS Newsletter → https://t.co/WpVbWdMvNf",
            timeStamp: "2022-10-09T08:23:38.000Z",
            authorName: "Mayank Gupta👨‍💻🥑",
            authorUsername: "iosmayank",
            profileImageURL: "https://pbs.twimg.com/profile_images/1515405040625745920/-qJQzUa5_bigger.jpg",
            photosURL: nil,
            category: nil,
            userVerified: false),
        
        AWSTweet(
            id: "C477F2CF-3DCB-49F1-B77D-E6ED5528C8F1",
            tweetID: "1579155290947485696",
            text: "a few months ago i really started finding interest in computer vision. now i\'ve spent the past few weeks messing with ARKit and RealityKit, and having a lot#and#uoi$%#ask of fun!\n\na lot of separate \".generatePlane\" ModelEntity\'s + one USDZ file (field goal post) #RealityKit #ARKit #AR #SwiftUI https://t.co/vZ3H0t4bv6",
            timeStamp: "2022-10-09T17:02:15.000Z",
            authorName: "hunter ",
            authorUsername: "hntrcodes",
            profileImageURL: "https://pbs.twimg.com/profile_images/1577568264175091722/apKZEJrj_bigger.jpg",
            photosURL: ["https://pbs.twimg.com/media/FepHGNtWYAIR2BI.jpg"],
            category: nil,
            userVerified: false),
        
        AWSTweet(
            id: "9C9B226D-24B4-45D4-9632-5A604A3E86AB",
            tweetID: "1569916764326166534",
            text: "Learn this new background task modifier for SwiftUI in my new #help... article! https://t.co/po8CExQhaY #apple #iOS #coding #Swift #SwiftUI",
            timeStamp: "2022-09-14T05:11:38.000Z",
            authorName: "Leonardo Pugliese",
            authorUsername: "Leo_Pugliese",
            profileImageURL: "https://pbs.twimg.com/profile_images/1243079749423038464/t50iTav1_bigger.jpg",
            photosURL: nil,
            category: nil,
            userVerified: false),
        
        AWSTweet(
            id: "047EF8B3-F2BF-4BAC-9AF5-EC515901ACED",
            tweetID: "1579740738140897280",
            text: "I finally reached €4k MRR. 🥳\n\nI switched my apps to subscriptions 2 years ago. Before, I usually made around €1k a month (paid upfront).\n\nNow they pay my bills, and I can focus 100% on growing them even further. 🤗\n\n#buildinpublic https://t.co/o4u9EHAg7I",
            timeStamp: "2022-10-11T07:48:36.000Z",
            authorName: "Florian Mielke",
            authorUsername: "FlorianMielke",
            profileImageURL: "https://pbs.twimg.com/profile_images/1509431457634213891/4rokDzVd_bigger.jpg", photosURL: ["https://pbs.twimg.com/media/FexcLs7WQAUIoKt.jpg"],
            category: nil,
            userVerified: false)
    ]
}

