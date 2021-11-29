//
//  TweetPhotosView.swift
//  brain-marks
//
//  Created by Fandrian Rhamadiansyah on 29/11/21.
//

import SwiftUI

struct TweetPhotosView: View {
    var width: CGFloat
    var maxWidth: CGFloat
    let photosURL: [String]
    
    var body: some View {
        if (photosURL.count == 1) {
            singlePhoto
                .cornerRadius(10)
                .padding(EdgeInsets(top: 0, leading: 18, bottom: 18, trailing: 18))
        } else if (photosURL.count == 2) {
            twoPhotos
                .cornerRadius(10)
                .padding(EdgeInsets(top: 0, leading: 18, bottom: 18, trailing: 18))
        } else {
            multiplePhotos
                .cornerRadius(10)
                .padding(EdgeInsets(top: 0, leading: 18, bottom: 18, trailing: 18))
        }
        
    }
    
    var singlePhoto: some View {
        AsyncImage(url: URL(string: photosURL.first!)!,
                   placeholder: {
            Image(systemName: "photo")
                .accentColor(Color(UIColor.label))
        })
            .scaledToFill()
            .frame(minWidth: width * 2,
                   maxWidth: maxWidth * 2,
                   minHeight: width * 0.8 * 2,
                   maxHeight: maxWidth * 0.8 * 2)
            .clipped()
    }
    
    var twoPhotos: some View {
        HStack(spacing: 5) {
            ForEach(photosURL[0..<photosURL.count], id: \.self) { url in
                AsyncImage(url: URL(string: url)!,
                           placeholder: {
                    Image(systemName: "photo")
                        .accentColor(Color(UIColor.label))
                })
                    .scaledToFill()
                    .frame(maxWidth: maxWidth,
                           minHeight: width,
                           maxHeight: maxWidth)
//                    .aspectRatio(5/4, contentMode: .fill)
                    .clipped()
            }
        }
    }
    
    var multiplePhotos: some View {
        LazyVGrid(columns: [
            GridItem(.flexible(minimum: width, maximum: maxWidth), spacing: 5),
            GridItem(.flexible(minimum: width, maximum: maxWidth), spacing: 5)],
                  spacing: 5) {
            ForEach(photosURL[0..<photosURL.count], id: \.self) { url in
                AsyncImage(url: URL(string: url)!,
                           placeholder: {
                    Image(systemName: "photo")
                        .accentColor(Color(UIColor.label))
                })
                    .scaledToFill()
                    .frame(maxWidth: maxWidth,
                           minHeight: width * 0.8,
                           maxHeight: maxWidth * 0.8)
                    .aspectRatio(5/4, contentMode: .fill)
                    .clipped()
            }
        }
    }
}

struct TweetPhotosView_Previews: PreviewProvider {
    static let multipleDummyPhotos = [
        "https://pbs.twimg.com/media/FFDQtmVUYAc4wHj.jpg",
        "https://pbs.twimg.com/media/FFDQubKVQAAyRvG.jpg",
        "https://pbs.twimg.com/media/FFDQvvsUcAAsAHf.jpg",
        "https://pbs.twimg.com/media/FE5U1sdVUAIXeNM.jpg"
    ]
    static let singlePhotos = ["https://pbs.twimg.com/media/FFDQtmVUYAc4wHj.jpg"]
    static var previews: some View {
        TweetPhotosView(width: 200, maxWidth: 500, photosURL: singlePhotos)
    }
}
