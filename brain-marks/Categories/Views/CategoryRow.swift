//
//  CategoryRow.swift
//  brain-marks
//
//  Created by Shloak Aggarwal on 11/04/21.
//

import SwiftUI

struct CategoryRow: View {
    let category: AWSCategory

    var body: some View {
        Label(category.name, systemImage: category.imageName ?? "folder")
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CategoryRow(category: AWSCategory(id: "234", name: "SwiftUI", imageName: "swift"))
            CategoryRow(category: AWSCategory(id: "987", name: "BigBrainHacks", imageName: "laptopcomputer"))
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
