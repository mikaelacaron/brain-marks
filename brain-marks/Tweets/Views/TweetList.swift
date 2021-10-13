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
        ScrollView(.vertical, showsIndicators: false) {
            geoReader
            Text("No tweets saved!")
                .font(.title3)
                .fontWeight(.medium)
        }
    }
    
    
    /// Using ScrollView allows us to utilize a Geometry Reader to get the amount in which the user pulls down to then allow us to set perameters of when to trigger our fetch.
    var tweets: some View {
        List {
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
    
    var geoReader: some View {
        ZStack {
            Image(systemName: "arrow.down")
                .opacity(refresh.pullStart ? 1 : 0)
                .rotationEffect(Angle(degrees: refresh.startOffset > 90 ? 180 : 0))
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
        }
    }
}

struct RefreshPull {
    var startOffset : CGFloat = 0
    var offset : CGFloat = 0
    var pullStart : Bool
    var pullStopped : Bool
}


