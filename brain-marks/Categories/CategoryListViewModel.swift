//
//  CategoryListViewModel.swift
//  brain-marks
//
//  Created by Mikaela Caron on 4/11/21.
//

import SwiftUI
import os.log

final class CategoryListViewModel: ObservableObject {
    
    @Published var categories = [AWSCategory]()
    
    @Published var categoryOrder: [String] = [String]()
    var lastEditedCategoryID = ""
    
    init() {
        getCategoryOrder()
    }
    
    /// To get the categories from `DataStoreManager`
    func getCategories() {
        categories = []
        DataStoreManger.shared.fetchCategories { result in
            switch result {
            case .success(let categories):
                DispatchQueue.main.async {
                    self.categories = self.sortCategories(categories)
                }
            case .failure(let error):
                Logger.dataStore.error("Error fetching categories: \(error)")
            }
        }
    }
    
    /// To delete the category with specified `offsets`
    /// - Parameter offsets: It is an `IndexSet` type parameter used to delete category from each offset in `DataStoreManager`
    func deleteCategory(at offsets: IndexSet) {
        for offset in offsets {
            let category = categories[offset]
            DataStoreManger.shared.deleteCategory(category: category)
        }
        categories.remove(atOffsets: offsets)
    }
    
    /// To sort the categories
    /// - Parameter categories: It is a list of `AWSCategory` ordered by `id`
    /// - Returns: A list of `AWSCategory`
    func sortCategories(_ categories: [AWSCategory]) -> [AWSCategory] {
        // Match Arrays order the the one stored in UserDefaults
        var orderedCategories = [AWSCategory]()
        
        guard !categoryOrder.isEmpty else {
            setCategoryOrder(with: categories)
            return categories
        }
        
        for id in categoryOrder {
            orderedCategories.append(
                categories.first(where: { awsCategory in
                    return awsCategory.id == id
                }) ?? AWSCategory(name: "Error loading Category"))
        }
        
        if categoryOrder.count < categories.count && categories.last != nil {
            orderedCategories.append(categories.last!)
        }
        
        setCategoryOrder(with: orderedCategories)
        
        return orderedCategories
    }
    
    /// To set the category order and save
    /// - Parameter categories: A list of `AWSCategory`to be ordered
    func setCategoryOrder(with categories: [AWSCategory]) {
        categoryOrder = [String]()
        for category in categories {
            categoryOrder.append(category.id)
        }
        saveCategoryOrder()
    }
    
    /// To save the category order in `UserDefaults`
    func saveCategoryOrder() {
        UserDefaults.standard.set(categoryOrder, forKey: "categoryOrder")
    }
    
    /// To get the category order from `UserDefaults`
    func getCategoryOrder() {
        categoryOrder = (UserDefaults.standard.array(forKey: "categoryOrder")) as? [String] ?? [String]()
    }
}
