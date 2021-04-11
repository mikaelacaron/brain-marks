//
//  ContentView.swift
//  brain-marks
//
//  Created by Mikaela Caron on 4/10/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showAddSheet = false

    var body: some View {
        VStack {
            CategoryList(categories: [
                Category(id: 0, name: "SwiftUI", numberOfTweets: 3, imageName: "swift"),
                Category(id: 1, name: "BigBrainHacks", numberOfTweets: 5, imageName: "laptopcomputer")
            ])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
