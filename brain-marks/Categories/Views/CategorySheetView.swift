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
    @State private var categoryThumbnail = "folder"
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
                                                          imageName: "folder"))
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
                case .new: title = "NewCategory"
                case .edit: title = "EditCategory"
                }
            }
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
