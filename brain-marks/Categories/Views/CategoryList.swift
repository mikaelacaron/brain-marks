//
//  CategoryList.swift
//  brain-marks
//
//  Created by Shloak Aggarwal on 11/04/21.
//

import SwiftUI
import os.log

enum CategoryState {
    case edit
    case new
}

struct CategoryList: View {
    @Binding var activeTab: Int
    @State private var categorySheetState: CategoryState = .new
    @State private var editCategory: AWSCategory?
    @State private var indexSetToDelete: IndexSet?
    @State private var showAddURLView = false
    @State private var showInfoSheet = false
    @State private var showingCategorySheet = false
    @State private var showingDeleteActionSheet = false
    @State private var editMode: EditMode = .inactive
    @StateObject var viewModel = CategoryListViewModel()
    
    var body: some View {
        
        NavigationView {
            categoryList
                .navigationTitle("Categories")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            categorySheetState = .new
                            showingCategorySheet.toggle()
                            endEditMode()
                        } label: {
                            Image(systemName: "folder.badge.plus")
                        }
                        .sheet(isPresented: $showingCategorySheet) {
                            CategorySheetView(
                                activeTab: $activeTab, 
                                editCategory: $editCategory,
                                categorySheetState: $categorySheetState, parentVM: viewModel)
                                .onDisappear {
                                    viewModel.getCategories()
                                }
                        }.onDisappear {
                            DataStoreManger
                                .shared.fetchSingleCategory(byID: viewModel.lastEditedCategoryID) { result in
                                switch result {
                                    
                                case .success(let newEditCategory):
                                    editCategory = newEditCategory
                                case .failure(let error):
                                    Logger.dataStore.error("❌ Error setting editCategory: \(error)")
                                }
                            }
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showAddURLView = true
                            endEditMode()
                        } label: {
                            Image(systemName:"plus.circle")
                        }
                        .sheet(isPresented: $showAddURLView) {
                            AddURLView(categories: viewModel.categories)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            if editMode == .inactive {
                                withAnimation(.linear.speed(1.3)) {
                                    editMode = .active
                                }
                            } else {
                                endEditMode()
                            }
                        } label: {
                            Text(editMode == .inactive ? "Edit" : "Done")
                                .animation(nil)
                                .onDisappear {
                                    endEditMode()
                                }
                        }
                    }
                }
                .environment(\.editMode, $editMode)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            viewModel.getCategories()
        }
        .accentColor(Color(UIColor.label))
        .onOpenURL { url in
          guard let action = url.host else {
            return
          }
          switch action {
          case "addCategory":
            showingCategorySheet = true
          case "addTweet":
            showAddURLView = true
          default:
            return
          }
        }
    }
    
    @ViewBuilder
    var categoryList: some View {
        if viewModel.categories.isEmpty {
            ZStack {
                Image("logo")
                    .opacity(0.05)
            VStack {
                Text("CategoriesAreEmpty")
                HStack(spacing: 0) {
                    Text("PleaseAddNewCategories")
                    Image(systemName: "folder.badge.plus")
                }
            }
            }
        } else {
            categories
        }
    }
    
    var emptyListView: some View {
        Text("YouHaventCreatedCategories")
            .font(.title3)
            .fontWeight(.medium)
    }
    
    var categories: some View {
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
            .onMove(perform: { indexSet, int in
                viewModel.categories.move(fromOffsets: indexSet, toOffset: int)
            })
            .onDelete { indexSet in
                showingDeleteActionSheet = true
                indexSetToDelete = indexSet
            }
            .onChange(of: viewModel.categories) { newValue in
                viewModel.setCategoryOrder(with: newValue)
            }
            .onAppear {
                viewModel.getCategoryOrder()
            }
        }.listStyle(InsetGroupedListStyle())
            .actionSheet(isPresented: $showingDeleteActionSheet) {
                ActionSheet(title: Text("AllCategoriesWillBeDeleted"), buttons: [
                    .destructive(Text("Delete"), action: {
                        guard indexSetToDelete != nil else {
                            return
                        }
                        viewModel.deleteCategory(at: indexSetToDelete!)
                        viewModel.setCategoryOrder(with: viewModel.categories)
                    }),
                    .cancel()
                ])
            }
    }
    
    func endEditMode() {
        withAnimation(.linear.speed(1.3)) {
            editMode = .inactive
        }
    }
}

struct CategoryList_Previews: PreviewProvider {
    static var previews: some View {
        CategoryList(activeTab: .constant(0))
    }
}
