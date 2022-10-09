//
//  JSONDataManager.swift
//  brain-marks
//
//  Created by Mikaela Caron on 5/13/22.
//

import Foundation

final class JSONDataManager {
    private init() { }
    
    static let shared = JSONDataManager()
    
    /// Move data from AWS Amplify DataStore to JSON files, and delete everything in AWS Amplify DataStore.
    func migrationToJSON() { }
    
    // MARK: - Categories
    
    /// Fetch all the categories
    /// - Parameter completion: Result, array of `AWSCategory` or Error
    func fetchCategories(completion: @escaping (Result<[AWSCategory], Error>) -> Void) { }
    
    /// Fetch a single category by the ID
    /// - Parameters:
    ///   - byID: ID of the category to search for
    ///   - completion: Result type containing AWSCategory or Error
    func fetchSingleCategory(byID: String, completion: @escaping (Result<AWSCategory?, Error>) -> Void) { }
    
    /// Create a new cateogry
    /// - Parameter category: `AWSCategory` to create
    func createCategory(category: AWSCategory) { }
    
    /// Delete a category and all it's tweets
    /// - Parameter category: `AWSCategory` to delete
    func deleteCategory(category: AWSCategory) { }
    
    /// Edit a category's name
    /// - Parameter category: `AWSCategory` to edit
    func editCategory(category: AWSCategory, newName: String) { }
    
    // MARK: - Tweets
    
    /// Create a new tweet for a specific cateogry
    /// - Parameters:
    ///   - tweet: `ReturnedTweet` tweet to save
    ///   - category: `AWSCategory` category to save tweet to
    func createTweet(tweet: ReturnedTweet, category: AWSCategory) { }
    
    /// Fetch all the saved tweets for a specific category
    /// - Parameters:
    ///   - category: `AWSCategory` which category to fetch the tweets from
    ///   - completion: Optional array of `AWSTweet` that are returned
    func fetchSavedTweets(for category: AWSCategory, completion: @escaping ([AWSTweet]?) -> Void) { }
    
    /// Delete a specific tweet
    /// - Parameter tweet: `AWSTweet` to delete
    func deleteTweet(_ tweet: AWSTweet) { }
}
