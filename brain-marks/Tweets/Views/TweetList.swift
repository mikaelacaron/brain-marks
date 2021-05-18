//
//  TweetList.swift
//  brain-marks
//
//  Created by Shloak Aggarwal on 11/04/21.
//

import SwiftUI

struct TweetList: View {
    @State var editMode = EditMode.inactive
    @State var selection = Set<String>()
    
    let category: AWSCategory
    
    @StateObject var viewModel = TweetListViewModel()
    
    var body: some View {
//        NavigationView{
            List(selection: $selection) { 
                ForEach(viewModel.tweets, id: \.self){tweet in
                TweetCard(tweet: tweet)
                .onTapGesture {
                    print("opening twitter for \(tweet.tweetID)\(tweet.authorUsername)")
                    self.openTwitter(tweetID: tweet.tweetID, authorUsername: tweet.authorUsername!)
                }}.onDelete(perform: { indexSet in
                    //delete method
                })
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
//        }
//        .navigationBarTitle("",displayMode: .inline)
//        .navigationBarItems(leading: deleteButton, trailing: editButton)
//        .environment(\.editMode, self.$editMode)
    }
    func openTwitter(tweetID:String, authorUsername:String){
       let appURL = NSURL(string: "twitter://home")!
       let webURL = NSURL(string: "https://twitter.com/\(authorUsername)/status/\(tweetID)?s=21")!

       let application = UIApplication.shared

       if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
       } else {
            application.open(webURL as URL)
       }
    
    }
    //
    private var editButton: some View {
        if editMode == .inactive {
            return Button(action: {
                self.editMode = .active
                self.selection = Set<String>()
            }) {
                Text("Edit")
            }
        }
        else {
            return Button(action: {
                self.editMode = .inactive
                self.selection = Set<String>()
            }) {
                Text("Done")
            }
        }
    }
    private var deleteButton: some View {
        if editMode == .inactive {
            return Button(action: {}) {
                Image(systemName: "")
            }
        } else {
            return Button(action: deleteTweets) {
                Image(systemName: "trash")
            }
        }
    }
    private func deleteTweets() {

    }
}
