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
    
    func deleteCategory(at offsets: IndexSet) {
        for offset in offsets {
            let category = categories[offset]
            DataStoreManger.shared.deleteCategory(category: category)
        }
        categories.remove(atOffsets: offsets)
    }
    
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
    
    func setCategoryOrder(with categories: [AWSCategory]) {
        categoryOrder = [String]()
        for category in categories {
            categoryOrder.append(category.id)
        }
        saveCategoryOrder()
    }
    
    func saveCategoryOrder() {
        UserDefaults.standard.set(categoryOrder, forKey: "categoryOrder")
    }
    
    func getCategoryOrder() {
        categoryOrder = (UserDefaults.standard.array(forKey: "categoryOrder")) as? [String] ?? [String]()
    }
}
