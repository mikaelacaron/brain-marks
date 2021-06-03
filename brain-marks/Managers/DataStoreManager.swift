//
//  DataStoreManager.swift
//  brain-marks
//
//  Created by Mikaela Caron on 4/11/21.
//

import Amplify
import SwiftUI

class DataStoreManger {
    
    private init() {}
    
    static let shared = DataStoreManger()
    
    // MARK: - Categories
    
    /// Fetch all the categories
    /// - Parameter completion: Result, array of `AWSCategory` or Error
    func fetchCategories(completion: @escaping (Result<[AWSCategory], Error>) -> Void) {
        Amplify.DataStore.query(AWSCategory.self) { result in
            switch result {
            case .success(let categories):
                completion(.success(categories))
            case .failure(let error):
                print("❌ did NOT get categories: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    /// Fetch a single category by the ID
    /// - Parameters:
    ///   - byID: ID of the category to search for
    ///   - completion: Result type containing AWSCategory or Error
    func fetchSingleCategory(byID: String, completion: @escaping (Result<AWSCategory?, Error>) -> Void) {
        Amplify.DataStore.query(AWSCategory.self, byId: byID) { result in
            switch result {
            case .success(let category):
                print("✅ Got single category: \(category)")
                completion(.success(category))
            case .failure(let error):
                print("❌ did NOT get categories: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    /// Create a new cateogry
    /// - Parameter category: `AWSCategory` to create
    func createCategory(category: AWSCategory) {
        Amplify.DataStore.save(category) { result in
            switch result {
            case .success:
                print("✅ saved category")
            case .failure(let error):
                print("❌ did NOT save category: \(error)")
            }
        }
    }
    
    
    /// Delete a category and all it's tweets
    /// - Parameter category: `AWSCategory` to delete
    func deleteCategory(category: AWSCategory) {
        Amplify.DataStore.delete(category) { result in
            switch result {
            case .success():
                print("✅ Deleted category")
            case .failure(let error):
                print("❌ Could NOT delete category: \(error)")
            }
        }
    }
    
    // MARK: - Tweets
    
    /// Create a new tweet for a specific cateogry
    /// - Parameters:
    ///   - tweet: `ReturnedTweet` tweet to save
    ///   - category: `AWSCategory` category to save tweet to
    func createTweet(tweet: ReturnedTweet, category: AWSCategory) {
        let awsTweet = AWSTweet(id: UUID().uuidString,
                                tweetID: tweet.id,
                                text: tweet.text,
                                authorName: tweet.authorName,
                                authorUsername: tweet.authorUsername,
                                category: category)
        
        Amplify.DataStore.save(awsTweet) { result in
            switch result {
            case .success:
                print("✅ saved tweet")
            case .failure(let error):
                print("❌ did NOT save tweet: \(error)")
            }
        }
    }
    
    /// Fetch all the saved tweets for a specific category
    /// - Parameters:
    ///   - category: `AWSCategory` which category to fetch the tweets from
    ///   - completion: Optional array of `AWSTweet` that are returned
    func fetchSavedTweets(for category: AWSCategory, completion: @escaping (Swift.Array<AWSTweet>?) -> Void) {
        
        Amplify.DataStore.query(AWSCategory.self) { result in
            switch result {
            case .success(let categories):
                
                for selectedCategory in categories {
                    if selectedCategory.name == category.name {
                        if selectedCategory.tweets != nil {
                            completion(Array(selectedCategory.tweets!))
                        }
                    }
                }
            case .failure(let error):
                print("❌ did NOT get categories which are needed to get tweets: \(error)")
            }
        }
    }
    
    /// Delete a specific tweet
    /// - Parameter tweet: `AWSTweet` to delete
    func deleteTweet(_ tweet: AWSTweet) {
        Amplify.DataStore.delete(tweet) { result in
            switch result {
            case .success():
                print("✅ Deleted tweet")
            case .failure(let error):
                print("❌ Could NOT delete tweet: \(error)")
            }
        }
    }
}
