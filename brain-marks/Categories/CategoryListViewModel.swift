//
//  CategoryListViewModel.swift
//  brain-marks
//
//  Created by Mikaela Caron on 4/11/21.
//

import SwiftUI

final class CategoryListViewModel: ObservableObject {

    let storageProvider: StorageProvider

    @Published var categories: [CategoryEntity]

    init() {
        /// Using a compiler statement here to determine where the code is being ran.
        /// A compiler statement was chosen so that it doesn't interfere with run time
        /// in production.
        ///
        /// If it's being ran in the canvas (preview) then we want to use the preview container
        /// If it's being ran not in the canvas, then we want to use the CoreData file for existing data.
        #if DEBUG
        // Checks if the code is running in the canvas (preview)
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            storageProvider = .preview
        } else {
            storageProvider = .shared
        }
        #else
        storageProvider = .shared
        #endif
        categories = []
    }
    
    func getCategories() {
        categories = storageProvider.getAllCategories()
    }
    
    func deleteCategory(at offsets: IndexSet) {
        for _ in offsets {
            offsets.sorted(by: >).forEach { index in
                let category = categories[index]
                storageProvider.context.delete(category)
                do {
                    try storageProvider.context.save()
                } catch {
                    print("❌ CategoryListViewModel.deleteCategory(at:) Error \(error)")
                }
            }
        }
        withAnimation {
            categories.remove(atOffsets: offsets)
        }
    }
}
