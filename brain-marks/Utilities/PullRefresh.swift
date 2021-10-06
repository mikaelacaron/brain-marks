//
//  PullRefresh.swift
//  brain-marks
//
//  Created by Rob Maltese on 10/6/21.
//

import SwiftUI

/*
 Goal :
        Get pull to refresh working for iOS 14+
 */


struct PullRefresh: View {
    
    var coordinateSpace: CoordinateSpace
    
    @StateObject var viewModel = TweetListViewModel()
    let category: AWSCategory


    var body: some View {
        GeometryReader { geo in
            if (geo.frame(in: coordinateSpace).midY > 50.0) {
                Spacer()
                    .onAppear {
                        viewModel.fetchTweets(category: category)
                    }
            }
            
        }
    }
}

//struct PullRefresh_Previews: PreviewProvider {
//    static var previews: some View {
//        PullRefresh()
//    }
//}
