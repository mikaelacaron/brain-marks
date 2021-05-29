//
//  CategoryList.swift
//  brain-marks
//
//  Created by Shloak Aggarwal on 11/04/21.
//

import SwiftUI

struct CategoryList: View {
    @State private var showAddURLView = false
    @StateObject var viewModel = CategoryListViewModel()
    
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView {
            List(viewModel.categories) { category in
                NavigationLink(destination: TweetList(category: category)) {
                    CategoryRow(category: category)
                }
                
            }.listStyle(InsetGroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationTitle("Categories")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button {
                        showingSheet.toggle()
                    } label: {
                        Image(systemName: "folder.badge.plus")
                    }
                    .sheet(isPresented: $showingSheet) {
                        NewCategorySheetView()
                            .onDisappear {
                            viewModel.getCategories()
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        self.showAddURLView = true
                    } label: {
                        Image(systemName:"plus.circle")
                            .font(.largeTitle)
                    }
                    
                }
            }
        }
        .onAppear {
            viewModel.getCategories()
        }
        .accentColor(.black)
        .sheet(isPresented:$showAddURLView) {
            AddURLView(categories: viewModel.categories)
        }
    }
}

struct CategoryList_Previews: PreviewProvider {
    static var previews: some View {
        CategoryList()
    }
}
