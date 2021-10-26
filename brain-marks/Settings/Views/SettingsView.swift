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
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        NavigationView {
            VStack {
                Form {
                    
                    Section {
                        Text(infoViewModel.infoText)
                    }
                    
                    Section {
                        
                        Text(infoViewModel.openSourceRemark)
                        
                        NavigationLink {
                            ContributorsListView(viewModel: viewModel)
                        } label: {
                            HStack {
                                Image(systemName: "person.3.fill")
                                Text("List of Contributors")
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
                                Text("Report a Bug")
                            }
                        }
                        
                        Link(destination: viewModel.urls["mikaelacaronProfile"]!) {
                            HStack {
                                Image(systemName: "person")
                                    .font(Font.body.weight(.bold))
                                Text("Mikaela Caron")
                            }
                        }
                        
                        Link(destination: viewModel.urls["brain-marksRepo"]!) {
                            HStack {
                                Image("githubLogo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 18, height: 18)
                                    .padding(.leading, 2)
                                
                                Text("GitHub Repository")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                    
                    VStack(alignment: .center) {
                        Text(infoViewModel.message)
                            .font(.title3)
                        .foregroundColor(.blue)
                        
                        Text(infoViewModel.title)
                            .font(.title)
                            .bold()
                        
                        if let appVersion = infoViewModel.appVersion {
                            Text(appVersion)
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
