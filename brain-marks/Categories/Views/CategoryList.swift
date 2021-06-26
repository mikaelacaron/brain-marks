//
//  CategoryList.swift
//  brain-marks
//
//  Created by Shloak Aggarwal on 11/04/21.
//

import SwiftUI

enum CategoryState {
    case edit
    case new
}

struct CategoryList: View {
    
    @State private var categorySheetState: CategoryState = .new
    @State private var editCategory: AWSCategory?
    @State private var indexSetToDelete: IndexSet?
    @State private var showAddURLView = false
    @State private var showingCategorySheet = false
    @State private var showingDeleteActionSheet = false
    
    @StateObject var viewModel = CategoryListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.categories) { category in
                    NavigationLink(destination: TweetList(category: category)) {
                        CategoryRow(category: category)
                    }
                    .contextMenu {
                        Button {
                            editCategory = category
                            categorySheetState = .edit
                            showingCategorySheet.toggle()
                        } label: {
                            Text("Edit")
                        }
                    }
                }
                .onDelete { indexSet in 
                    showingDeleteActionSheet = true
                    indexSetToDelete = indexSet
                }
            }.listStyle(InsetGroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationTitle("Categories")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button {
                        categorySheetState = .new
                        showingCategorySheet.toggle()
                    } label: {
                        Image(systemName: "folder.badge.plus")
                    }
                    .sheet(isPresented: $showingCategorySheet) {
                        CategorySheetView(
                            editCategory: $editCategory,
                            categorySheetState: $categorySheetState)
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
                    .sheet(isPresented: $showAddURLView) {
                        AddURLView(categories: viewModel.categories)
                    }
                }
            }
        }
        .onAppear {
            viewModel.getCategories()
        }
        .actionSheet(isPresented: $showingDeleteActionSheet) {
            ActionSheet(title: Text("Category and all tweets will be deleted"), buttons: [
                .destructive(Text("Delete"), action: {
                    guard indexSetToDelete != nil else {
                        return
                    }
                    viewModel.deleteCategory(at: indexSetToDelete!)
                }),
                .cancel()
            ])
        }
        .accentColor(.black)
    }
}

struct CategoryList_Previews: PreviewProvider {
    static var previews: some View {
        CategoryList()
    }
}
