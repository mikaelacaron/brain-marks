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
    
    @StateObject var viewModel = CategoryListViewModel()
    
    var body: some View {
        NavigationView {
            categoryList
                .navigationTitle("Categories")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            viewModel.didTapAddCategory()
                        } label: {
                            Image(systemName: "folder.badge.plus")
                        }
                        .sheet(isPresented: $viewModel.showingCategorySheet) {
                            CategorySheetView(
                                editCategory: $viewModel.editCategory,
                                categorySheetState: $viewModel.categorySheetState,
                                lastEditedCategoryID: $viewModel.lastEditedCategoryID
                            )
                            .onDisappear {
                                viewModel.getCategories()
                            }
                        }.onDisappear {
                            viewModel.refreshLastEditedCategory()
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            viewModel.showAddURLView = true
                        } label: {
                            Image(systemName:"plus.circle")
                        }
                        .sheet(isPresented: $viewModel.showAddURLView) {
                            AddURLView(categories: viewModel.categories)
                        }
                    }
                }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            viewModel.getCategories()
        }
        .accentColor(Color(UIColor.label))
    }
    
    @ViewBuilder
    var categoryList: some View {
        if viewModel.categories.isEmpty {
            ZStack {
                Image("logo")
                    .opacity(0.05)
                emptyListView
            }
        } else {
            categories
        }
    }
    
    var emptyListView: some View {
        VStack {
            Text("CategoriesAreEmpty")
            HStack(spacing: 0) {
                Text("PleaseAddNewCategories")
                Image(systemName: "folder.badge.plus")
            }
        }
    }
    
    var categories: some View {
        List {
            ForEach(viewModel.categories) { category in
                NavigationLink(destination: TweetList(category: category)) {
                    CategoryRow(category: category)
                }
                .contextMenu {
                    Button {
                        viewModel.didTapEdit(category)
                    } label: {
                        Text("Edit")
                    }
                }
            }
            .onDelete { indexSet in
                viewModel.confirmDelete(at: indexSet)
            }
        }
        .listStyle(InsetGroupedListStyle())
        .actionSheet(isPresented: $viewModel.showingDeleteActionSheet) {
            ActionSheet(title: Text("AllCategoriesWillBeDeleted"), buttons: [
                .destructive(Text("Delete"), action: {
                    viewModel.deleteCategory()
                }),
                .cancel()
            ])
        }
    }
}

struct CategoryList_Previews: PreviewProvider {
    static var previews: some View {
        CategoryList()
    }
}
