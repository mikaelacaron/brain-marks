//
//  StorageProvider+Tweet.swift
//  brain-marks
//
//  Created by Jay on 12/13/22.
//

import Foundation
import CoreData

extension StorageProvider {
    func saveTweet(_ entity: TweetEntity) {
        context.insert(entity)
        do {
            try context.save()
        } catch {
            print("StorageProvider.saveTweet(:): Error \(error)")
        }
    }

    func getAllTweets() -> [TweetEntity] {
        let fetchRequest: NSFetchRequest<TweetEntity> = TweetEntity.fetchRequest()

        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("StorageProvider.getAllTweets(:): Error \(error)")
            return []
        }
    }
}
