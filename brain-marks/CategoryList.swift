//
//  CategoryList.swift
//  brain-marks
//
//  Created by Shloak Aggarwal on 11/04/21.
//

import SwiftUI

struct CategoryList: View {

    var categories: [Category]

    var body: some View {
        NavigationView {
            List(categories) { category in
                 NavigationLink(destination: TweetList(category: category)) {
                    CategoryRow(category: category)
                }
            
            }.listStyle(InsetGroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationTitle("Categories")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("New Category") {
                        
                    }
                    
                    Spacer()
                    
                    Button("Add Tweet") {
                        
                    }
                }
            }
        }
    }
}

struct CategoryList_Previews: PreviewProvider {
    static var previews: some View {
        CategoryList(categories: [
            Category(id: 0,
                     name: "SwiftUI",
                     numberOfTweets: 3,
                     imageName: "swift"),
            Category(id: 1,
                     name: "BigBrainHacks",
                     numberOfTweets: 5,
                     imageName: "laptopcomputer")
        ])
    }
}
