//
//  SettingsView.swift
//  brain-marks
//
//  Created by AC Richter on 22.10.21.
//

import SwiftUI

struct SettingsView<ViewModel: InfoViewModel>: View {
    let infoViewModel: ViewModel
    
    @StateObject var viewModel = SettingsViewModel()
    @StateObject var appIconSettings = AppIconSettings()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    
                    Section(header: Text("About")) {
                        Text(infoViewModel.infoText)
                    }
                    
                    Section(header: Text("Contributions")) {
                        
                        Text(infoViewModel.openSourceRemark)
                        
                        NavigationLink {
                            ContributorsListView(viewModel: viewModel)
                        } label: {
                            HStack {
                                Image(systemName: "person.3.fill")
                                Text("ListOfContributors")
                            }
                        }
                    }
                    
                    Section(header: Text("Appearance")) {
                        NavigationLink {
                            AppIconListView(appIconSettings: appIconSettings)
                        } label: {
                            HStack {
                                Text("App Icon")
                                Spacer()
                                Text(appIconSettings.currentIconName ?? "Default")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    
                    Section(header: HStack {
                        Image(systemName: "link")
                        Text("Links")
                    }) {
                        
                        Link(destination: viewModel.urls["bugReport"]!) {
                            HStack {
                                Image(systemName: "exclamationmark.triangle")
                                    .font(Font.body.weight(.bold))
                                Text("ReportABug")
                            }
                        }
                        
                        Link(destination: viewModel.urls["mikaelacaronProfile"]!) {
                                Text("🦄  Mikaela Caron - Maintainer")
                        }
                        
                        Link(destination: viewModel.urls["brain-marksRepo"]!) {
                            HStack {
                                Image("githubLogo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 18, height: 18)
                                    .padding(.leading, 2)
                                
                                Text("GitHubRepo")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                    
                    VStack(alignment: .center) {
                        HStack(spacing: 0) {
                            Text("❤️ ")
                            Text(infoViewModel.message)
                            Text(" ❤️")
                        }
                            .font(.title3)
                            .foregroundColor(.blue)
                        
                        Text(infoViewModel.title)
                            .font(.title)
                            .bold()
                        
                        if let appVersion = infoViewModel.appVersion {
                            HStack(spacing: 0) {
                                Text("Version ")
                                Text(appVersion)
                            }
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.automatic)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SettingsView_Previews_1: PreviewProvider {
    static var previews: some View {
        TabView {
            SettingsView(infoViewModel: DefaultInfoViewModel())
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
        }
    }
}
