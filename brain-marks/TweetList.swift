//
//  TweetList.swift
//  brain-marks
//
//  Created by Shloak Aggarwal on 11/04/21.
//

import SwiftUI

struct TweetList: View {
    var category: AWSCategory
    
    var body: some View {
        
        List {
            TweetCard()
        }        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Image(systemName: category.imageName ?? "swift")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                    Text(category.name)
                }
            }
        }
    }
}
