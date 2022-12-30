//
//  CategoryListViewModel.swift
//  brain-marks
//
//  Created by Mikaela Caron on 4/11/21.
//

import SwiftUI

final class CategoryListViewModel: ObservableObject {

    let storageProvider: StorageProvider

    @Published var categories = [CategoryEntity]()

    init(inMemory: Bool = false) {
        storageProvider = inMemory ? StorageProvider.preview : StorageProvider.shared
    }
    
    func getCategories() {
        categories = storageProvider.getAllCategories()
    }
    
    func deleteCategory(at offsets: IndexSet) {
        categories.remove(atOffsets: offsets)
    }
    
    func editCategoryName(category: AWSCategory, newName: String) {
        DataStoreManger.shared.editCategory(category: category, newName: newName)
    }
}
