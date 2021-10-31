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
        
        TabView {
            
            CategoryList()
                .tabItem {
                    Image(systemName: "list.star")
                    Text("Tweets")
                }
            
            SettingsView(infoViewModel: DefaultInfoViewModel())
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
