//
//  TweetListViewModel.swift
//  brain-marks
//
//  Created by Mikaela Caron on 4/11/21.
//

import SwiftUI

final class TweetListViewModel: ObservableObject {
    
    @Published var tweets = [AWSTweet]()
    var dataStoreManager: DataStoreManager = AmplifyDataStoreManger.shared
    
    func fetchTweets(category: AWSCategory) {
        dataStoreManager.fetchSavedTweets(for: category) { tweets in
            if let tweets = tweets {
                self.tweets = tweets
            }
        }
    }
    
    func deleteTweet(at offsets: IndexSet) {
        for _ in offsets {
            offsets.sorted(by: >).forEach { index in
                let tweet = tweets[index]
                dataStoreManager.deleteTweet(tweet)
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
