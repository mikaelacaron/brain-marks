//
//  ContributorProfileView.swift
//  brain-marks
//
//  Created by AC Richter on 25.10.21.
//

import SwiftUI

struct ContributorProfileView: View {
    
    var name: String
    var imgUrl: String
    
    init(name: String, url: String) {
        
        self.name = name
        self.imgUrl = url
        
        self.name = (name.first?.uppercased())! + name.dropFirst()
    }
    
    private let imgFrame: CGFloat = 30
    var body: some View {
        
        HStack {
            
            AsyncImage(url: URL(string: imgUrl)!, placeholder: {
                Circle()
                    .frame(width: imgFrame, height: imgFrame)
                    .redacted(reason: .placeholder)
                    .foregroundColor(.gray)
                
            }, image: { image in
                Image(uiImage: image)
                    .resizable()
                
            })
                .aspectRatio(contentMode: .fit)
                .frame(width: imgFrame, height: imgFrame)
                .clipShape(Circle())
            
            Text(name)
            
        }
    }
}
