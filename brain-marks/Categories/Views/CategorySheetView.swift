//
//  CategorySheetView.swift
//  brain-marks
//
//  Created by Mikaela Caron on 5/1/21.
//

import SwiftUI

struct CategorySheetView: View {
    
    @Binding var editCategory: AWSCategory?
    @Binding var categorySheetState: CategoryState
    @ObservedObject var parentVM: CategoryListViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    @Namespace var categoryThumbnailID
    @State private var category = ""
    @State private var title: LocalizedStringKey = ""
    @State private var categoryThumbnail = "folder"
    @State private var showCategoryGrid = false
    @StateObject private var viewModel = CategorySheetViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                textEntryView()
                
                thumbnailGridView()
            }
            .navigationBarTitle(title)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) { 
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) { 
                    Button {
                        presentationMode.wrappedValue.dismiss()
                            switch categorySheetState {
                            case .new:
                                if !category.isEmpty {
                                DataStoreManger.shared.createCategory(
                                    category: AWSCategory(name: category,
                                                          imageName: viewModel.thumbnail))
                                }
                            case .edit:
                                guard editCategory != nil else {
                                    return
                                }
                                parentVM.lastEditedCategoryID = categoryThumbnail
                                DataStoreManger.shared.editCategory(
                                    category: editCategory!,
                                    newName: category, newThumbnail: categoryThumbnail)
                            }
                        
                    } label: {
                        
                        switch categorySheetState {
                        case .new: Text("Create")
                        case .edit: Text("Edit")
                        }
                    }
                }
            }
            .onAppear {
                switch categorySheetState {
                case .new: title = "NewCategory"
                case .edit: title = "EditCategory"
                }
            }
        }
    }
    @ViewBuilder private func textEntryView() -> some View {
        switch categorySheetState {
            
        case .new:
            HStack {
                Button {
                    showCategoryGrid.toggle()
                } label: {
                    Image(systemName: viewModel.thumbnail)
                }
                
            TextField(LocalizedStringKey("EnterCategoryName"),
                             text: $category)
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
        case .edit: TextField("\(editCategory?.name ?? "")",
                              text: $category)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .onAppear {
                category = editCategory!.name
            }
            
        }
    }
    
    let columnStyle = [GridItem(), GridItem(), GridItem(), GridItem()]
    let  categorySFSymbols = ["folder", "book", "music.note",
                              "list.bullet", "gamecontroller", "brain.head.profile",
                              "star", "hands.clap", "bookmark",
                              "dollarsign.circle", "shippingbox", "laptopcomputer",
                              "chart.bar", "gift", "suit.heart", "pin",
                              "headphones", "moon", "crown", "person"]
    
    @ViewBuilder private func thumbnailGridView() -> some View {
        switch categorySheetState {
        case .new:
            newCategoryThumbnailGridView()
        case .edit:
            editCategoryThumbnailGridView()
        }
    }
    
    @ViewBuilder private func newCategoryThumbnailGridView() -> some View {
        ScrollView {
            LazyVGrid(columns: columnStyle) {
                ForEach(categorySFSymbols, id: \.self) { sfSymbol in
                    Button {
                        viewModel.selectThumbnail(sfSymbol)
                        self.categoryThumbnail = viewModel.thumbnail
                    } label: {
                        Image(systemName: sfSymbol)
                            .foregroundColor(viewModel.thumbnail == sfSymbol
                                             ? Color.primary
                                             : Color.blue
                            )
                            .padding()
                            .background(viewModel.thumbnail == sfSymbol
                                        ? Color.blue.opacity(0.4)
                                        : .clear)
                            .cornerRadius(10)
                    }
                }
            }
        }
    }
    
    @ViewBuilder private func editCategoryThumbnailGridView() -> some View {
        ScrollView {
            LazyVGrid(columns: columnStyle) {
                ForEach(categorySFSymbols, id: \.self) { sfSymbol in
                    Button {
                        categoryThumbnail = sfSymbol
                        editCategory?.imageName = sfSymbol
                        
                    } label: {
                        Image(systemName: sfSymbol)
                            .foregroundColor(categoryThumbnail == sfSymbol
                                             ? Color.primary
                                             : Color.blue
                            )
                            .padding()
                            .background(categoryThumbnail == sfSymbol
                                        ? Color.blue.opacity(0.4)
                                        : .clear)
                            .cornerRadius(10)
                    }
                }
            }
        }.onAppear {
            categoryThumbnail = editCategory!.imageName!
        }
    }
}

struct NewCategorySheetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CategorySheetView(
                editCategory: .constant(AWSCategory(id: "1",
                                                    name: "CategoryName",
                                                    imageName: "swift")),
                categorySheetState: .constant(.new), parentVM: CategoryListViewModel())
                .preferredColorScheme(.light)
            CategorySheetView(
                editCategory: .constant(AWSCategory(id: "1",
                                                    name: "CategoryName",
                                                    imageName: "swift")),
                categorySheetState: .constant(.new), parentVM: CategoryListViewModel())
                .preferredColorScheme(.dark)
        }
    }
}
