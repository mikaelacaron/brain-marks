//
//  CoreDataManager.swift
//  brain-marks
//
//  Created by Jay on 12/13/22.
//

import Foundation

class CoreDataManager {

    static let shared = CoreDataManager()

    private var storageProvider: StorageProvider

    init() {
        self.storageProvider = StorageProvider()
    }

    func addCategory(_ category: CategoryEntity) {
        do {
            try storageProvider.saveCategory(category)
        } catch {
            print("CoreDataManager.addCategory() Error: \(error)")
        }
    }
}
