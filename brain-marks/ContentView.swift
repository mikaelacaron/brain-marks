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
        NavigationView{
        VStack {
            CategoryList(categories: [
                Category(id: 0, name: "SwiftUI", numberOfTweets: 3, imageName: "swift"),
                Category(id: 1, name: "BigBrainHacks", numberOfTweets: 5, imageName: "laptopcomputer")
            ])
//            Button("hey",action: {
//                get(url: "https://twitter.com/mikaela__caron/status/1380956548042682370?s=21")
//            })
        }.navigationBarTitle("🧠",displayMode: .inline)
        .navigationBarItems(trailing: Button(action:{
            self.showAddSheet = true
        }){
            Image(systemName: "plus.circle")
                .font(.system(size: 30))
                .foregroundColor(.black)
        })
        }.sheet(isPresented:$showAddSheet){
            AddURLView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
