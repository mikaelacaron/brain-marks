//
//  CategoryListViewModel.swift
//  brain-marks
//
//  Created by Mikaela Caron on 4/11/21.
//

import SwiftUI

final class CategoryListViewModel: ObservableObject {
    
    @Published var categories = [AWSCategory]()
    
    func getCategories() {
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
    
}
