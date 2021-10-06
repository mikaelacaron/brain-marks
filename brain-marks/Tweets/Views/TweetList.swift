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
    @State var refresh = RefreshPull(pullStart: false, pullStopped: false)
    
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
        Text("No tweets saved!")
            .font(.title3)
            .fontWeight(.medium)
    }
    
    /// This variable uses a ScrollView instead of a List to implement the pull to refresh feature while targeting iOS 14.
    var tweets: some View {
        ScrollView(.vertical, showsIndicators: false) {
            // Geometry Reader
            GeometryReader { geo -> AnyView in
                DispatchQueue.main.async {
                    if refresh.startOffset == 0 {
                        refresh.startOffset = geo.frame(in: .global).minY
                    }
                    refresh.offset = geo.frame(in: .global).minY
                    
                    if refresh.offset - refresh.startOffset > 90 && !refresh.pullStart {
                        refresh.pullStart = true
                    }
                    
                    if refresh.startOffset == refresh.offset && refresh.pullStart && !refresh.pullStopped {
                        refresh.pullStopped = true
                        viewModel.fetchTweets(category: category)
                        print("Fetching Tweets!")
                    }
                }
                return AnyView(Color.white.frame(width: 0, height: 0))
            }
            .frame(width: 0, height: 0)
            // Content
            ForEach(viewModel.tweets) { tweet in
                VStack {
                    TweetCard(tweet: tweet)
                        .onTapGesture {
                            viewModel.openTwitter(tweetID: tweet.tweetID, authorUsername: tweet.authorUsername!)
                    }
                }
                Divider()
            }
            .onDelete { offsets in
                viewModel.deleteTweet(at: offsets)
            }
        }
    }
}

struct RefreshPull {
    var startOffset : CGFloat = 0
    var offset : CGFloat = 0
    var pullStart : Bool
    var pullStopped : Bool
}

/*
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
 */
/*
 
 ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
     Image(systemName: "arrow.down")
         .font(.system(size: 16, weight: .heavy))
         .foregroundColor(.gray)
         .offset(y: -25)
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
 */
