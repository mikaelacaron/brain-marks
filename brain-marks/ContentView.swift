//
//  ContentView.swift
//  brain-marks
//
//  Created by Mikaela Caron on 4/10/21.
//

import SwiftUI

struct ContentView: View {
    @State var activeTab = 0
  
    var body: some View {
        TabView(selection: $activeTab) {
          CategoryList(activeTab: $activeTab)
                .tabItem {
                    Image(systemName: "list.star")
                    Text("Tweets")
                }
                .tag(0)
            SettingsView(infoViewModel: DefaultInfoViewModel())
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
                .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
