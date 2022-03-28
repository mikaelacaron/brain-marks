//
//  TweetCard.swift
//  brain-marks
//
//  Created by Shloak Aggarwal on 11/04/21.
//

import SwiftUI

struct TweetCard: View {
    
    @State var tweet: AWSTweet
    
    var body: some View {
        VStack(alignment: .leading) {
            TweetHeaderView(tweet: tweet)
            TweetBodyView(tweetBody: tweet.text!)
            if let timeStamp = tweet.timeStamp {
                TimeStampView(timeStamp: timeStamp)
            }
            //            TweetFooterView()
        }
    }
}

struct TweetHeaderView: View {
    
    let tweet: AWSTweet
    
    var body: some View {
        HStack {
            UserIconView(url: tweet.profileImageURL ?? "", size: 55)
            UserInfoView(authorName: tweet.authorName ?? "",
                         authorUsername: tweet.authorUsername ?? "",
                         userVerified: tweet.userVerified ?? false)
            Spacer()
        }
        .padding(EdgeInsets(top: 18, leading: 18, bottom: 18, trailing: 18))
    }
}

struct TweetBodyView: View {
    @State var tweetBody: String
    var body: some View {
        hilightedText(str: tweetBody, searched: tweetBody.components(separatedBy: " ").first(where: { str in
            str.contains("#")
        }) ?? "#nil")
            .multilineTextAlignment(.leading)
            .font(.body)
            .lineSpacing(8.0)
            .padding(EdgeInsets(top: 0, leading: 18, bottom: 18, trailing: 18))
            .fixedSize(horizontal: false, vertical: true)
    }
    
    func hilightedText(str: String, searched: String) -> Text {
        guard !str.isEmpty && !searched.isEmpty else { return Text(str) }
        
        var result: Text!
        let parts = str.components(separatedBy: searched)
        for i in parts.indices {
            result = (result == nil ? Text(parts[i]) : result + Text(parts[i]))
            if i != parts.count - 1 {
                result = result + Text(searched)
                    .bold()
                    .foregroundColor(.blue)
            }
        }
        return result ?? Text(str)
    }
//    var body: some View {
//        HStack {
//            Text(tweetBody)
//        }
//            .font(.body)
//            .lineSpacing(8.0)
//            .padding(EdgeInsets(top: 0, leading: 18, bottom: 18, trailing: 18))
//            .fixedSize(horizontal: false, vertical: true)
//            .onAppear {
//                for word in tweetBody.components(separatedBy: " ") {
//                    if word.first == "#" {
//                        tweetBody = tweetBody.replacingOccurrences(of: word, with: "[\(word)](https://twitter.com/search?q=%23\(word)&src=typeahead_click)")
//                    }
//                }
//            }
//    }
}

struct TweetFooterView: View {
    var body: some View {
        VStack(alignment: .leading) {
            TweetInfoView()
            
            Divider().padding(EdgeInsets(top: 0, leading: 18, bottom: 6, trailing: 18))
            InteractionsView()
            Divider().padding(EdgeInsets(top: 4, leading: 18, bottom: 0, trailing: 18))
        }
    }
}

struct UserIconView: View {
    
    @State var url: String
    var size: CGFloat
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: url)!,
                       placeholder: {
                Image(systemName: "person.fill").accentColor(Color(UIColor.label))
            })
                .aspectRatio(contentMode: .fit)
                .frame(width: size, height: size)
                .clipShape(Circle())
        }
    }
}

struct UserInfoView: View {
    
    let authorName: String
    let authorUsername: String
    let userVerified: Bool
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 4) {
                    Text(authorName)
                        .font(.headline)
                        .fontWeight(.semibold)
                    if userVerified {
                            Image("verified")
                                .resizable()
                                .frame(width: 14,
                                       height: 14,
                                       alignment: .center)
                    }
                                
                }
                Text("@\(authorUsername)")
                    .font(.callout)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
    }
}

struct TweetInfoView: View {
    var body: some View {
        HStack(spacing: 0) {
            Text("9:58 PM・9/5/20・")
                .font(.callout)
                .foregroundColor(.secondary)
            Text("Twitter for iPhone")
                .font(.callout)
                .foregroundColor(Color(UIColor(named: "twitter")!))
        }
        .padding(EdgeInsets(top: 18, leading: 18, bottom: 6, trailing: 18))
    }
}

struct InteractionsView: View {
    var body: some View {
        HStack {
            HStack(spacing: 4) {
                Text("501K")
                    .font(.system(size: 16, weight: .semibold, design: .default))
                Text("Retweets")
                    .font(.callout)
                    .foregroundColor(.secondary)
            }
            HStack(spacing: 4) {
                Text("9,847")
                    .font(.system(size: 16, weight: .semibold, design: .default))
                Text("Quote Tweets")
                    .font(.callout)
                    .foregroundColor(.secondary)
            }
            HStack(spacing: 4) {
                Text("1M")
                    .font(.system(size: 16, weight: .semibold, design: .default))
                Text("Likes")
                    .font(.callout)
                    .foregroundColor(.secondary)
            }
        }.padding(.horizontal)
    }
}

struct TimeStampView: View {
    let timeStamp: String
    
    var body: some View {
        Text(timeStamp.formatTimestamp())
            .font(.callout)
            .foregroundColor(.secondary)
            .padding(.horizontal, 18)
    }
}

struct TweetCard_Previews: PreviewProvider {
    static var previews: some View {
        TweetCard(tweet: AWSTweet(id: "123", tweetID: "234", text: "Tweet ext here"))
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
