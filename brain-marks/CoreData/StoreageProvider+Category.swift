//
//  StoreageProvider+Category.swift
//  brain-marks
//
//  Created by Jay on 12/13/22.
//

import Foundation
import CoreData

extension StorageProvider {
    func saveCategory(_ entity: CategoryEntity) throws {
        context.insert(entity)
        do {
            try context.save()
            print("✅ StorageProvider.saveCategory(:): SUCCESS")
        } catch {
            print("❌ StorageProvider.saveCategory(:): ERROR \(error)")
        }
    }

    func getAllCategories() -> [CategoryEntity] {
        let fetchRequest: NSFetchRequest<CategoryEntity> = CategoryEntity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "dateModified", ascending: false)]

        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("StorageProvider.getAllCategories(:): Error \(error)")
            return []
        }
    }
}
