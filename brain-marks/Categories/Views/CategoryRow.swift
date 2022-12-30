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
            Text(category.name ?? "No name")
            Spacer()
        }
    }
}

//struct CategoryRow_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            CategoryRow(category: CategoryEntity(id: "234", name: "SwiftUI", imageName: "swift"))
//            CategoryRow(category: CategoryEntity(id: "987", name: "BigBrainHacks", imageName: "laptopcomputer"))
//        }
//        .previewLayout(.fixed(width: 300, height: 70))
//    }
//}
