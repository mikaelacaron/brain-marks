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
    
    // This WORKS
    func fetchCategories(completion: @escaping (Result<[AWSCategory], Error>) -> Void) {
        Amplify.DataStore.query(AWSCategory.self) { result in
            switch result {
            case .success(let categories):
                print("✅ Got categories: \(categories)")
                completion(.success(categories))
            case .failure(let error):
                print("❌ did NOT get categories: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    // This WORKS
    func createCategory(category: Category) {
        let awsCategory = AWSCategory(name: category.name, imageName: category.imageName)
        
        Amplify.DataStore.save(awsCategory) { result in
            switch result {
            case .success:
                print("✅ saved category")
            case .failure(let error):
                print("❌ did NOT save category: \(error)")
            }
        }
    }
    
    // MARK: - Tweets
    
    // not working yet
    private func createTweet(tweet: TweetModel) {
        let awsTweet = AWSTweet(id: UUID().uuidString,
                                tweetID: tweet.id,
                                text: tweet.text,
                                category: nil)
        
        Amplify.DataStore.save(awsTweet) { result in
            switch result {
            case .success:
                print("✅ saved tweet")
            case .failure(let error):
                print("❌ did NOT save tweet: \(error)")
            }
        }
    }
    
    // not working yet
    private func fetchSavedTweets(for category: Category, completion: @escaping (Swift.Array<AWSTweet>?) -> Void) {
        
        Amplify.DataStore.query(AWSCategory.self) { result in
            switch result {
            case .success(let categories):
                print("✅ Got categories: \(categories)")
                
                for selectedCategory in categories {
                    if selectedCategory.name == category.name {
                        if selectedCategory.tweets != nil {
                            completion(Array(selectedCategory.tweets!))
                        }
                    }
                }
//                for category in categories {
//                    print("👏 \(category.tweets)")
//                    let counter: Int = category.tweets?.count ?? 0
//                    if counter == 0 {
//                        print("🚨 no tweets in this category")
//                    } else {    
//                        for index in 0...counter {
//                            print("🚀 \(category.tweets?[index])")
//                        }
//                    }
//                    
//                }
            case .failure(let error):
                print("❌ did NOT get categories: \(error)")
            }
        }
    }
}
