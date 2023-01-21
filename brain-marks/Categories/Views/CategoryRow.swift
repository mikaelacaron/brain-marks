//
//  CategoryRow.swift
//  brain-marks
//
//  Created by Shloak Aggarwal on 11/04/21.
//

import SwiftUI

struct CategoryRow: View {
    let category: CategoryEntity

    var body: some View {
        HStack {
            Image(systemName: category.imageName ?? "folder")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text(category.name ?? "Category name not found")
            Spacer()
        }
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        let context = StorageProvider.preview
        let items = context.getAllCategories()
        Group {
            CategoryRow(category: items.first!)
            CategoryRow(category: items.first!)
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
