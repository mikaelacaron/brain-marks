//
//  Category.swift
//  brain-marks
//
//  Created by Shloak Aggarwal on 11/04/21.
//

import Foundation
import SwiftUI

struct Category: Identifiable {
    var id: Int
    var name: String
    var numberOfTweets: Int
    var imageName: String

    init(id: Int, name: String, numberOfTweets: Int, imageName: String) {
        self.id = id
        self.name = name
        self.numberOfTweets = numberOfTweets
        self.imageName = imageName
    }
}
