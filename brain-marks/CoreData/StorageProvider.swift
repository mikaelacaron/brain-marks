//
//  StorageProvider.swift
//  brain-marks
//
//  Created by Jay on 12/13/22.
//

import Foundation
import CoreData
import TelemetryClient

class StorageProvider {
    static var persistentContainer: NSPersistentContainer {
        let container = NSPersistentContainer(name: "BrainMarks")

        container.loadPersistentStores { description, error in
            if let error = error {
                TelemetryManager.send(TelemetrySignals.errorCoreDataLoad)
                fatalError("Core Data store failed to load with error: \(error)")
            }
            print("Loaded Core Data \(description)")
        }

        return container
    }

    var context: NSManagedObjectContext {
        return Self.persistentContainer.viewContext
    }
}
