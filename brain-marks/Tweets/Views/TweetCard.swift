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
            
            if (tweet.text!.removingUrls() != "") {
                TweetBodyView(tweetBody: tweet.text!.removingUrls())
            }
            TweetPhotosView(width: 60, maxWidth: 400, photosURL: tweet.photosURL ?? [String]())
            if let timeStamp = tweet.timeStamp {
                TimeStampView(timeStamp: timeStamp)
            }
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
    let tweetBody: String
    var body: some View {
        TextHighlightingHashtags(tweetBody)
            .font(.body)
            .lineSpacing(8.0)
            .padding(EdgeInsets(top: 0, leading: 18, bottom: 18, trailing: 18))
            .fixedSize(horizontal: false, vertical: true)
    }
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

// swiftlint:disable shorthand_operator
private extension TweetBodyView {
    
    /// Use this Text View to highlight and #s in tweets following Twitter's hashtag rules.
    /// Only alphanumeric characters directly after a # symbol will be highlighted.
    /// Any other symbols before or after a # will not be highlighted.
    /// - Parameter tweet: The string to have occurances of hashtags highlighted.
    /// - Returns: A text view where words preceeded by "#" are highlighted.
    func TextHighlightingHashtags(_ tweet: String) -> Text {
        
        guard tweet.contains("#") else { return Text(tweet) }
        
        var output = Text("")
        let words = tweet.split(separator: " ")
        
        for word in words {
            if let hashtagIndex = word.firstIndex(of: "#") {
                
                // Avoid highlighting the first part of a word preceeding a #
                let prefixString = word.prefix(upTo: hashtagIndex)
                output = output + Text(" ") + Text(prefixString)
                
                let hashtagIndexPlusOne = word.index(hashtagIndex,
                                                     offsetBy: 1)
                let hashtagPlusSuffixString = word.suffix(
                    from: hashtagIndexPlusOne)
                
                if let suffixIndex = hashtagPlusSuffixString.firstIndex(
                    where: {!$0.isNumber && !$0.isLetter}) {
                    // If the # word is followed by non-alphanumeric symbols do not highlight the symbols
                    let hashtagString = hashtagPlusSuffixString.prefix(
                        upTo: suffixIndex)
                    
                    if hashtagString.count < 1 {
                        // If # is on its own or followed by symbols do not highlight.
                        output = output + Text("#")
                    } else {
                        let hashtagText = Text("#" + hashtagString)
                            .foregroundColor(Color("twitter"))
                        output = output + hashtagText
                    }
                    
                    let suffixString = hashtagPlusSuffixString[suffixIndex...]
                    output = output + Text(suffixString)
                    
                } else {
                    // If there are no symbols at the end of a string highlight the whole string after the #
                    output = output + Text("#" + hashtagPlusSuffixString).foregroundColor(Color("twitter"))
                }
            } else {
                // If word does not contain # do not highlight
                output = output + Text(" ") + Text(String(word))
            }
        }
        return output
    }
}

struct TweetCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TweetCard(tweet: AWSTweet.exampleAWSTweets[0])
            TweetCard(tweet: AWSTweet.exampleAWSTweets[1])
            TweetCard(tweet: AWSTweet.exampleAWSTweets[2])
            TweetCard(tweet: AWSTweet.exampleAWSTweets[3])
            TweetCard(tweet: AWSTweet.exampleAWSTweets[4])
        }
        .previewLayout(PreviewLayout.sizeThatFits)
    }
}
