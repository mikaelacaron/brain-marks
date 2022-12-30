//
//  TweetListViewModel.swift
//  brain-marks
//
//  Created by Mikaela Caron on 4/11/21.
//

import SwiftUI

final class TweetListViewModel: ObservableObject {
    private let storageProvider = StorageProvider.shared
    
    @Published var tweets = [TweetEntity]()

    func setTweets(tweets: NSSet) {
        for tweet in tweets {
            self.tweets.append(tweet as! TweetEntity)
        }
    }
    
    func deleteTweet(at offsets: IndexSet) {
        for _ in offsets {
            offsets.sorted(by: >).forEach { index in
                let tweet = tweets[index]
                storageProvider.context.delete(tweet)
                do {
                    try storageProvider.context.save()
                } catch {
                    print("❌ TweetListViewModel.deleteTweet(at:) Error \(error)")
                }
            }
        }
        tweets.remove(atOffsets: offsets)
    }
    
    /// Opens Twitter app when tapping on tweet card
    func openTwitter(tweetID:String, authorUsername:String) {
        let appURL = NSURL(string: "twitter://\(authorUsername)/status/\(tweetID)?s=21")!
        let webURL = NSURL(string: "https://twitter.com/\(authorUsername)/status/\(tweetID)?s=21")!
        
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            application.open(webURL as URL)
        }
    }
}
