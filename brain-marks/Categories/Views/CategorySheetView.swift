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
                toggableThumbnailGridView()
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
                Menu {
                    Button(action: {
                        withAnimation {
                            self.showCategoryGrid.toggle()
                        }
                    }){
                        Text("Change icon")
                    }
                    
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
    let  choosableSFSymbols = ["folder", "book", "person", "house.fill", "book.fill", "person.fill", "star", "xmark"]
    
    @ViewBuilder private func toggableThumbnailGridView() -> some View {
        if showCategoryGrid {
            VStack {
                LazyVGrid(columns: columnStyle) {
                    ForEach(choosableSFSymbols, id: \.self){ sfSymbol in
                        // Two approaches in mind:
                        // 1: Have the images the normal size without modification, renders a pretty small sf symbol
                        // 2: Make them .resizable and make them an appropriate size
                        
                        // Any color schemes to be aware of?
                        
                        Button(action: {viewModel.selectThumbnail(sfSymbol) }) {
                            Image(systemName: sfSymbol)
                                .padding()
                                .background(viewModel.thumbnail == sfSymbol
                                            ? Color.blue.opacity(0.4)
                                            : .clear)
                                .matchedGeometryEffect(id: sfSymbol, in: categoryThumbnailID)
                                
                                .cornerRadius(10)
                        }
                    }
                }.transition(.scale)
                HStack {
                    //TODO: - NAMING OF FUNC - CONFIRM SELECTION?
                    Button(action: confirmSelection){
                        Text("Ok")
                            .padding(.vertical, 8)
                            .frame(width: UIScreen.main.bounds.width * 0.45)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                }.buttonStyle(.plain)
            }
            
        }
    }
    private func confirmSelection() {
        withAnimation {
            self.categoryThumbnail = viewModel.thumbnail
            showCategoryGrid = false
        }
    }
}

struct NewCategorySheetView_Previews: PreviewProvider {
    static var previews: some View {
        CategorySheetView(
            editCategory: .constant(AWSCategory(id: "1",
                                                name: "CategoryName",
                                                imageName: "swift")),
            categorySheetState: .constant(.new))
    }
}
