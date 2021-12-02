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
    
    @Environment(\.presentationMode) var presentationMode
    
    @Namespace var categoryThumbnailID
    @State private var category = ""
    @State private var title = ""
    @State private var categoryThumbnail = "book"
    @State private var showCategoryGrid = false
    @StateObject private var viewModel = CategorySheetViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                textEntryView()
                thumbnailGridView()
                Spacer()
                HStack(spacing: 25) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                            .frame(width: 150, height: 50)
                            .foregroundColor(.white)
                            .background(Color(UIColor(named: "twitter")!))
                            .font(.system(size: 20, weight: .semibold, design: .default))
                            .cornerRadius(10)
                    }
                    
                    Button {
                        presentationMode.wrappedValue.dismiss()
                        
                        if !category.isEmpty {
                            
                            switch categorySheetState {
                            case .new:
                                DataStoreManger.shared.createCategory(
                                    category: AWSCategory(name: category,
                                                          imageName: viewModel.thumbnail))
                            case .edit:
                                guard editCategory != nil else {
                                    return
                                }
                                
                                DataStoreManger.shared.editCategory(
                                    category: editCategory!,
                                    newName: category)
                            }
                        }
                    } label: {
                        
                        switch categorySheetState {
                        case .new: BMButton(text: "Create")
                        case .edit: BMButton(text: "Edit")
                        }
                    }
                }
                .padding(20)
            }
            .navigationBarTitle(title)
            .onAppear {
                switch categorySheetState {
                case .new: title = "New Category"
                case .edit: title = "Edit Category"
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
                
            TextField("Enter name of new category",
                             text: $category)
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
        case .edit: TextField("\(editCategory?.name ?? "")",
                              text: $category)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
        }
    }
    
    let columnStyle = [GridItem(), GridItem(), GridItem(), GridItem()]
    let  categorySFSymbols = ["folder", "book", "cross",
                               "star.bubble", "leaf", "brain.head.profile",
                               "star", "hands.clap"]
    
    @ViewBuilder private func thumbnailGridView() -> some View {
            VStack {
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
}

struct NewCategorySheetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CategorySheetView(
                editCategory: .constant(AWSCategory(id: "1",
                                                    name: "CategoryName",
                                                    imageName: "swift")),
                categorySheetState: .constant(.new))
                .preferredColorScheme(.light)
            CategorySheetView(
                editCategory: .constant(AWSCategory(id: "1",
                                                    name: "CategoryName",
                                                    imageName: "swift")),
                categorySheetState: .constant(.new))
                .preferredColorScheme(.dark)
        }
    }
}
