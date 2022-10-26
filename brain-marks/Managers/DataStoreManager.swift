//
//  DataStoreManager.swift
//  brain-marks
//
//  Created by Mikaela Caron on 4/11/21.
//

import Amplify
import SwiftUI
import os.log

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
                Logger.dataStore.error("❌ did NOT get categories: \(error)")
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
                Logger.dataStore.debug("✅ Got single category: \(String(describing: category))")
                completion(.success(category))
            case .failure(let error):
                Logger.dataStore.error("❌ did NOT get categories: \(error)")
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
                Logger.dataStore.debug("✅ saved category")
            case .failure(let error):
                Logger.dataStore.error("❌ did NOT save category: \(error)")
            }
        }
    }
    
    /// Delete a category and all it's tweets
    /// - Parameter category: `AWSCategory` to delete
    func deleteCategory(category: AWSCategory) {
        Amplify.DataStore.delete(category) { result in
            switch result {
            case .success:
                Logger.dataStore.debug("✅ Deleted category")
            case .failure(let error):
                Logger.dataStore.error("❌ Could NOT delete category: \(error)")
            }
        }
    }
    
    /// Edit a category's name
    /// - Parameter category: `AWSCategory` to edit
    func editCategory(category: AWSCategory, newName: String, newThumbnail: String) {
        Amplify.DataStore.query(AWSCategory.self, where: AWSCategory.keys.id.eq(category.id)) { result in
            switch result {
            case .success(let categories):
                guard categories.count == 1, var updatedCategory = categories.first else {
                    Logger.dataStore.debug("Couldn't find exact category to edit")
                    return
                }
                updatedCategory.name = newName
                updatedCategory.imageName = newThumbnail
                Amplify.DataStore.save(updatedCategory) { result in
                    switch result {
                    case .success(let savedCategory):
                        Logger.dataStore.debug("✅ Updated Category: \(savedCategory.name)")
                    case .failure(let error):
                        Logger.dataStore.error("❌ Failed category update \(updatedCategory.name) - \(error)")
                    }
                }
            case .failure(let error):
                Logger.dataStore.error("❌ Could NOT query DataStore: \(error)")
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
                                timeStamp: tweet.timeStamp,
                                authorName: tweet.authorName,
                                authorUsername: tweet.authorUsername,
                                profileImageURL: tweet.profileImageURL,
                                photosURL: tweet.photosUrl,
                                category: category,
                                userVerified: tweet.userVerified)
        
        Amplify.DataStore.save(awsTweet) { result in
            switch result {
            case .success:
                Logger.dataStore.debug("✅ saved tweet")
            case .failure(let error):
                Logger.dataStore.error("❌ did NOT save tweet: \(error)")
            }
        }
    }
    
    /// Fetch all the saved tweets for a specific category
    /// - Parameters:
    ///   - category: `AWSCategory` which category to fetch the tweets from
    ///   - completion: Optional array of `AWSTweet` that are returned
    func fetchSavedTweets(for category: AWSCategory, completion: @escaping ([AWSTweet]?) -> Void) {
        
        Amplify.DataStore.query(AWSCategory.self) { result in
            switch result {
            case .success(let categories):
                
                for selectedCategory in categories {
                    if selectedCategory.name == category.name && selectedCategory.tweets != nil {
                        completion(Array(selectedCategory.tweets!))
                    }
                }
            case .failure(let error):
                Logger.dataStore.error("❌ did NOT get categories which are needed to get tweets: \(error)")
            }
        }
    }
    
    /// Delete a specific tweet
    /// - Parameter tweet: `AWSTweet` to delete
    func deleteTweet(_ tweet: AWSTweet) {
        Amplify.DataStore.delete(tweet) { result in
            switch result {
            case .success:
                Logger.dataStore.debug("✅ Deleted tweet")
            case .failure(let error):
                Logger.dataStore.error("❌ Could NOT delete tweet: \(error)")
            }
        }
    }
}
