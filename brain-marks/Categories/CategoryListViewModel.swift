//
//  CategoryListViewModel.swift
//  brain-marks
//
//  Created by Mikaela Caron on 4/11/21.
//

import SwiftUI

final class CategoryListViewModel: ObservableObject {
    
    @Published var categories = [AWSCategory]()
    
    var lastEditedCategoryID = ""
    
    func getCategories() {
        categories = []
        DataStoreManger.shared.fetchCategories { result in
            switch result {
            case .success(let categories):
                DispatchQueue.main.async {
                    self.categories = categories
                }
            case .failure(let error):
                print("Error fetching categories: \(error)")
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
    
//    func editCategoryName(category: AWSCategory, newName: String) {
//        DataStoreManger.shared.editCategory(category: category, newName: newName, newThumbnail: <#String#>)
//    }
}
