//
//  ContributorsListView.swift
//  brain-marks
//
//  Created by AC Richter on 22.10.21.
//

import SwiftUI

// swiftlint:disable line_length

struct ContributorsListView: View {
    
    @StateObject var viewModel: SettingsViewModel
    
    var body: some View {
        
        List {
            if (viewModel.contributors?.isEmpty) != nil {
                ForEach(viewModel.contributors!, id: \.self) { contributor in
                    
                    Link(destination: (URL(string: contributor.htmlURL) ?? viewModel.urls["brain-marksRepo"])!) {
                        ContributorProfileView(name: contributor.login, url: contributor.avatarURL)
                    }
                    
                }
            } else {
                ForEach(viewModel.staticContributors, id: \.self) { contributor in

                    HStack {
                        Circle()
                            .foregroundColor(.gray)
                            .frame(width: 30, height: 30)
                        
                        Text(contributor)
                    }
                }
            }
        }
        .onAppear {
            viewModel.getContributors()
        }
        .navigationBarHidden(false)
        .navigationTitle("Contributors")
        .navigationBarTitleDisplayMode(.automatic)
    }
}
