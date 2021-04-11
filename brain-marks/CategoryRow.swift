//
//  CategoryRow.swift
//  brain-marks
//
//  Created by Shloak Aggarwal on 11/04/21.
//

import SwiftUI

struct CategoryRow: View {
    var category: Category

    var body: some View {
        HStack {
            Image(systemName: category.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text(category.name)
            Spacer()
        }
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CategoryRow(category: Category(id: 0, name: "SwiftUI", numberOfTweets: 3, imageName: "swift"))
            CategoryRow(category: Category(id: 1, name: "BigBrainHacks", numberOfTweets: 5, imageName: "laptopcomputer"))
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
