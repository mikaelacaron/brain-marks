//
//  StorageProvider.swift
//  brain-marks
//
//  Created by Jay on 12/13/22.
//

import Foundation
import CoreData
import TelemetryClient

final class StorageProvider {

    static let shared = StorageProvider()

    let container: NSPersistentContainer

    static var preview: StorageProvider = {
        let controller = StorageProvider(inMemory: true)
        for num in 0..<10 {
            let category = CategoryEntity(context: controller.context)
            category.name = "Category \(num)"
            category.id = UUID()
            category.dateCreated = Date()
            category.dateModified = Date()
            for tweetNum in 0..<5 {
                let tweet = TweetEntity(context: controller.context)
                tweet.id = UUID()
                tweet.dateCreated = Date()
                tweet.authorName = "heyjaywilson"
                tweet.text = "this is a sample tweet \(tweetNum)"
                category.addToTweets(tweet)
            }
        }
        do {
            try controller.context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return controller
    }()

    private init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "BrainMarks")

        if inMemory {
            if #available(iOS 16.0, *) {
                container.persistentStoreDescriptions.first?.url = URL(filePath: "/dev/null")
            } else {
                container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
            }
        }
        container.loadPersistentStores { description, error in
            if let error = error {
                TelemetryManager.send(TelemetrySignals.errorCoreDataLoad)
                fatalError("Core Data store failed to load with error: \(error)")
            }
            print("Loaded Core Data \(description)")
        }
    }

    var context: NSManagedObjectContext {
        return container.viewContext
    }
}
