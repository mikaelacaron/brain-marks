//
//  CategorySheetViewModel.swift
//  brain-marks
//
//  Created by Sergio Bost on 10/24/21.
//

import SwiftUI

final class CategorySheetViewModel: ObservableObject {
    @Published var thumbnail: String = "folder"
    
    func selectThumbnail(_ thumbnail: String) {
        withAnimation {
            self.thumbnail = thumbnail
        }
    }
}
