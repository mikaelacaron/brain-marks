//
//  TweetList.swift
//  brain-marks
//
//  Created by Shloak Aggarwal on 11/04/21.
//

import SwiftUI

struct TweetList: View {
    
    let category: CategoryEntity
    
    @StateObject var viewModel = TweetListViewModel()
    
    var body: some View {
        tweetList
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image(systemName: category.imageName ?? "swift")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                        Text(category.name ?? "No name")
                    }
                }
            }
            .onAppear {
//                viewModel.fetchTweets(category: category)
            }
    }
    
    @ViewBuilder
    var tweetList: some View {
        if viewModel.tweets.isEmpty {
            emptyListView
        } else {
            tweets
        }
    }
    
    var emptyListView: some View {
        Text("No tweets saved!")
            .font(.title3)
            .fontWeight(.medium)
    }
    
    var tweets: some View {
        List {
            ForEach(viewModel.tweets) { tweet in
                TweetCard(tweet: tweet)
                    .onTapGesture {
                        viewModel.openTwitter(tweetID: tweet.tweetID, authorUsername: tweet.authorUsername!)
                    }
            }
            .onDelete { offsets in
                viewModel.deleteTweet(at: offsets)
            }
        }
    }
}
