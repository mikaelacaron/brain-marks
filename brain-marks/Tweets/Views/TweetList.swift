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
    @State private var selectedTweet: AWSTweet?
    
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
                        Text(category.name)
                    }
                }
            }
            .onAppear {
                viewModel.fetchTweets(category: category)
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
        Text("NoSavedTweets")
            .font(.title3)
            .fontWeight(.medium)
    }
    
    var tweets: some View {
        List {
            if #available(iOS 15, *) {
                ForEach(viewModel.tweets) { tweet in
                    TweetCard(tweet: tweet)
                        .swipeActions(edge: .leading, allowsFullSwipe: true) {
                            Button {
                                selectedTweet = tweet
                            } label: {
                                Label("Move", systemImage: "folder")
                            }
                            .tint(.blue)
                        }
                        .swipeActions(allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                viewModel.delete(tweet)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .onTapGesture {
                            viewModel.openTwitter(
                                tweetID: tweet.tweetID,
                                authorUsername: tweet.authorUsername ?? ""
                            )
                        }
                        .sheet(item: $selectedTweet, content: { tweet in
                            TweetCategoryList(tweet: tweet, viewModel: viewModel)
                                .tint(.primary)
                        })
                }
            } else {
                ForEach(viewModel.tweets) { tweet in
                    TweetCard(tweet: tweet)
                }
                .onDelete { indexSet in
                    viewModel.deleteTweet(at: indexSet)
                }
            }
        }
        .listStyle(.plain)
    }
}
