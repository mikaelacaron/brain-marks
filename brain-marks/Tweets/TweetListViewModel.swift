//
//  TweetListViewModel.swift
//  brain-marks
//
//  Created by Mikaela Caron on 4/11/21.
//

import SwiftUI

final class TweetListViewModel: ObservableObject {
    
    @Published var tweets = [AWSTweet]()
    
    func fetchTweets(category: AWSCategory) {
        DataStoreManger.shared.fetchSavedTweets(for: category) { tweets in
            if let tweets = tweets {
                self.tweets = tweets
            }
        }
    }
}
