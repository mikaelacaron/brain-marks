//
//  TweetListViewModel.swift
//  brain-marks
//
//  Created by Mikaela Caron on 4/11/21.
//

import SwiftUI

final class TweetListViewModel: ObservableObject {
    
    @Published var tweets = [AWSTweet]()
    
    /// To fetch the tweets from `DataStoreManager`
    /// - Parameter category: An `AWSCategory` category to fetch tweets.
    func fetchTweets(category: AWSCategory) {
        DataStoreManger.shared.fetchSavedTweets(for: category) { tweets in
            if let tweets = tweets {
                self.tweets = tweets
            }
        }
    }
    
    /// To delete tweet
    /// - Parameter offsets: An `IndexSet` specifying the offsets to delete from `DataStoreManager`
    func deleteTweet(at offsets: IndexSet) {
        for _ in offsets {
            offsets.sorted(by: >).forEach { index in
                let tweet = tweets[index]
                DataStoreManger.shared.deleteTweet(tweet)
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
