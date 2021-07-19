//
//  TweetList.swift
//  brain-marks
//
//  Created by Shloak Aggarwal on 11/04/21.
//

import SwiftUI

struct TweetList: View {
    
    let category: AWSCategory
    
    @StateObject var viewModel = TweetListViewModel()
    
    var body: some View {
        
        List(viewModel.tweets) { tweet in
            TweetCard(tweet: tweet)
                .onTapGesture {
                    viewModel.openTwitter(tweetID: tweet.tweetID, authorUsername: tweet.authorUsername!)
                }
        }
        .toolbar {
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
        .onAppear {
            viewModel.fetchTweets(category: category)
        }
        
        Spacer()
    }
}
