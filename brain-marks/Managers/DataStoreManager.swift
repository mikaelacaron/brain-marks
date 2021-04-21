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
    
    // MARK: - Tweets
    
    func createTweet(tweet: Tweet, category: AWSCategory) {
        let awsTweet = AWSTweet(id: UUID().uuidString,
                                tweetID: tweet.id,
                                text: tweet.text,
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
}
