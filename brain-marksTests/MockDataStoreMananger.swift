//
//  MockDataStoreMananger.swift
//  brain-marksTests
//
//  Created by Andrew Erickson on 2022-05-14.
//

import Foundation
@testable import brain_marks

class MockDataStoreManager: DataStoreManager {

    var categoriesResult: Result<[AWSCategory], Error> = .success([])
    func fetchCategories(completion: @escaping (Result<[AWSCategory], Error>) -> Void) {
        completion(categoriesResult)
    }

    var singleCategoryResult: Result<AWSCategory?, Error> = .success(nil)
    var fetchSingleCategoryCallCount: Int = 0
    func fetchSingleCategory(byID: String, completion: @escaping (Result<AWSCategory?, Error>) -> Void) {
        completion(singleCategoryResult)
        fetchSingleCategoryCallCount += 1
    }

    func createCategory(category: AWSCategory) {
    }

    func deleteCategory(category: AWSCategory) {
    }

    func editCategory(category: AWSCategory, newName: String, newThumbnail: String) {
    }

    func createTweet(tweet: ReturnedTweet, category: AWSCategory) {
    }

    var savedTweets: [AWSTweet]?
    func fetchSavedTweets(for category: AWSCategory, completion: @escaping ([AWSTweet]?) -> Void) {
        completion(savedTweets)
    }

    func deleteTweet(_ tweek: AWSTweet) {
    }
}
