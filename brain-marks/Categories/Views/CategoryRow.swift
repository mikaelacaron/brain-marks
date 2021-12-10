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
        HStack {
            Image(systemName: category.imageName ?? "folder")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .font(Font.title.weight(.light))
            Text(category.name)
            Spacer()
        }
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
