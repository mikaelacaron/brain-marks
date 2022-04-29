//
//  TweetListViewModel.swift
//  brain-marks
//
//  Created by Mikaela Caron on 4/11/21.
//

import SwiftUI

final class TweetListViewModel: ObservableObject {
    
    @Published var tweets = [AWSTweet]()
    @Published var categories: [AWSCategory] = []

    /// When moving a tweet to another category, set this property
    /// with the tweet's category that is being moved so it is excluded
    /// from the list of categories the tweet can be moved to.
    var excludedCategory: AWSCategory?

    /// Retrieves all categories.
    ///
    /// If a value has been provided for the property `excludedCategory`, then
    /// the categories list will not include that category.
    func getCategories() {
        categories = []
        DataStoreManger.shared.fetchCategories { [weak self] result in
            switch result {
            case .success(let categories):
                let filteredCategories = categories.filter { $0 != self?.excludedCategory }

                DispatchQueue.main.async {
                    self?.categories = filteredCategories
                }
            case .failure(let error):
                print("Error fetching categories: \(error)")
            }
        }
    }
    
    func fetchTweets(category: AWSCategory) {
        DataStoreManger.shared.fetchSavedTweets(for: category) { tweets in
            if let tweets = tweets {
                self.tweets = tweets
            }
        }
    }

    /// Pre iOS 15 way of deleting tweets—`IndexSet` is needed
    func deleteTweet(at offsets: IndexSet) {
        for _ in offsets {
            offsets.sorted(by: >).forEach { index in
                let tweet = tweets[index]
                DataStoreManger.shared.deleteTweet(tweet)
            }
        }
        tweets.remove(atOffsets: offsets)
    }

    /// iOS 15 * way of deleting tweet
    func delete(_ tweet: AWSTweet) {
        withAnimation {
            tweets.removeAll(where: { $0.id == tweet.id })
        }
        
        DataStoreManger.shared.deleteTweet(tweet)
    }

    var lastEditedCategoryID = ""

    /// Move tweet to another category
    func move(
        _ tweet: AWSTweet,
        to category: AWSCategory,
        completion: @escaping (Result<AWSTweet, DataStoreManger.TweetError>) -> Void
    ) {
        DataStoreManger.shared.moveTweet(tweet, to: category) { [weak self] result in
            switch result {
            case .success(let updatedTweet):
                withAnimation {
                    self?.tweets.removeAll(where: { $0.id == tweet.id })
                }
                completion(.success(updatedTweet))
            case .failure(let error):
                completion(.failure(error))
            }
        }
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
