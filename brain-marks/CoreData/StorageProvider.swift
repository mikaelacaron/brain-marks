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
    let persistentContainer: NSPersistentContainer

    init() {
        persistentContainer = NSPersistentContainer(name: "BrainMarks")

        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                TelemetryManager.send(TelemetrySignals.errorCoreDataLoad)
                fatalError("Core Data store failed to load with error: \(error)")
            }
            print("Loaded Core Data \(description)")
        }
    }
}
