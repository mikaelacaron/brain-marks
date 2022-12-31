//
//  CategoryRow.swift
//  brain-marks
//
//  Created by Shloak Aggarwal on 11/04/21.
//

import SwiftUI

struct CategoryRow: View {
    let categoryName: String
    let categoryImage: String

    var body: some View {
        HStack {
            Image(systemName: categoryImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text(categoryName)
            Spacer()
        }
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CategoryRow(
                categoryName: "iOS Tips and Tricks",
                categoryImage: "folder"
            )
            CategoryRow(
                categoryName: "macOS Tips and Tricks",
                categoryImage: "swift"
            )
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
