//
//  TweetList.swift
//  brain-marks
//
//  Created by Shloak Aggarwal on 11/04/21.
//

import SwiftUI

struct TweetList: View {
    var category: Category
    
    var body: some View {
        
        List {
            Text("This is a tweet!")
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Image(systemName: category.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                    Text(category.name)
                }
            }
        }
        
        Spacer()
    }
}

struct TweetList_Previews: PreviewProvider {
    static var previews: some View {
        TweetList(category: Category(id: 0,
                                     name: "SwiftUI",
                                     numberOfTweets: 3,
                                     imageName: "swift"))
    }
}
