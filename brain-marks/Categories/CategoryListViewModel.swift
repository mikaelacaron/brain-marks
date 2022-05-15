//
//  CategoryListViewModel.swift
//  brain-marks
//
//  Created by Mikaela Caron on 4/11/21.
//

import SwiftUI

final class CategoryListViewModel: ObservableObject {
    
    @Published var categories = [AWSCategory]()
    @Published var categorySheetState: CategoryState = .new
    @Published var editCategory: AWSCategory?
    @Published var indexSetToDelete: IndexSet?
    @Published var showAddURLView = false
    @Published var showInfoSheet = false
    @Published var showingCategorySheet = false
    @Published var showingDeleteActionSheet = false
    @Published var lastEditedCategoryID = ""

    var dataStoreManager: DataStoreManager = AmplifyDataStoreManger.shared
    
    func getCategories(completion: (() -> Void)? = nil) {
        categories = []
        dataStoreManager.fetchCategories { result in
            switch result {
            case .success(let categories):
                DispatchQueue.main.async {
                    self.categories = categories
                    completion?()
                }
            case .failure(let error):
                print("Error fetching categories: \(error)")
                completion?()
            }
        }
    }

    func confirmDelete(at indexSet: IndexSet) {
        showingDeleteActionSheet = true
        indexSetToDelete = indexSet
    }
    
    func deleteCategory() {
        guard let offsets = indexSetToDelete else { return }

        for offset in offsets {
            let category = categories[offset]
            dataStoreManager.deleteCategory(category: category)
        }
        categories.remove(atOffsets: offsets)
    }

    func refreshLastEditedCategory() {
        guard !lastEditedCategoryID.isEmpty else { return }

        dataStoreManager.fetchSingleCategory(byID: lastEditedCategoryID) { result in
            switch result {
            case .success(let newEditCategory):
                self.editCategory = newEditCategory
            case .failure(let error):
                print("❌ Error setting editCategory: \(error)")
            }
        }
    }

    func didTapAddCategory() {
        categorySheetState = .new
        showingCategorySheet.toggle()
    }

    func didTapEdit(_ category: AWSCategory) {
        editCategory = category
        categorySheetState = .edit
        showingCategorySheet.toggle()
    }
}
