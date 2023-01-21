//
//  MigrationService.swift
//  brain-marks
//
//  Created by Jay on 12/13/22.
//

import CoreData
import Foundation

/// Controls the migration from Amplify to CoreData
final class MigrationService {
    private let storageProvider = StorageProvider.shared
    private var awsCategories: [AWSCategory] = []

    private let amplifyDataStore = DataStoreManger.shared

    private var managedObjectContext: NSManagedObjectContext

    init() {
        self.managedObjectContext = storageProvider.context
    }

    func performMigration() {
        amplifyDataStore.fetchCategories(completion: { result in
        switch result {
            case .success(let categories):
                self.awsCategories = categories
                self.addToCoreData()
            case .failure(let error):
                print("❌ MigrationService.getCategories(): Error: \(error)")
            }
        })
    }

    private func addToCoreData() {
        for awsCategory in awsCategories {
            let categoryToAdd = convertAmplifyCategoryToCoreDataCategory(category: awsCategory)
            amplifyDataStore.fetchSavedTweets(for: awsCategory) { awsTweets in
                for tweet in awsTweets ?? [] {
                    let tweetToAdd = self.convertAmplifyTweetToCoreDataTweet(tweet: tweet)
                    categoryToAdd.addToTweets(tweetToAdd)
                }
            }
            do {
                try managedObjectContext.save()
            } catch {
                print("❌ MigrationService.performMigration() Error: \(error)")
            }
        }
        UserDefaults.standard.set(true, forKey: "migrationToCoreDataRan")
    }


    func checkIfMigrationShouldRun() -> Bool {
        let migrationToCoreDataRan = UserDefaults.standard.bool(forKey: "migrationToCoreDataRan")

        if storageProvider.getAllCategories().isEmpty && !migrationToCoreDataRan {
            return true
        }
        return false
    }

    private func getCategories() {

    }

    private func convertAmplifyCategoryToCoreDataCategory(category: AWSCategory) -> CategoryEntity {
        let tweetCat = CategoryEntity(context: managedObjectContext)
        tweetCat.amplifyID = category.id
        tweetCat.id = UUID()
        tweetCat.dateCreated = Date()
        tweetCat.dateModified = Date()
        tweetCat.imageName = category.imageName ?? "folder"
        tweetCat.name = category.name

        return tweetCat
    }

    private func convertAmplifyTweetToCoreDataTweet(tweet: AWSTweet) -> TweetEntity {
        let tweetEntity = TweetEntity(context: managedObjectContext)
        tweetEntity.id = UUID(uuidString: tweet.id)
        tweetEntity.tweetID = tweet.tweetID
        tweetEntity.authorName = tweet.authorName
        tweetEntity.authorUsername = tweet.authorUsername
        tweetEntity.dateCreated = Date()
        tweetEntity.profileImageURL = tweet.profileImageURL
        tweetEntity.text = tweet.text

        return tweetEntity
    }
}
