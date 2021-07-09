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
                    self.openTwitter(tweetID: tweet.tweetID, authorUsername: tweet.authorUsername!)
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
    /// Opens twitter on tapping tweet card
    func openTwitter(tweetID:String, authorUsername:String){
       let appURL = NSURL(string: "twitter://\(authorUsername)/status/\(tweetID)?s=21")!
       let webURL = NSURL(string: "https://twitter.com/\(authorUsername)/status/\(tweetID)?s=21")!

       let application = UIApplication.shared

       if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
       } else {
            application.open(webURL as URL)
       }
    
    }
}
