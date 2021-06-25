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
    @State var category = ""
    
    @State private var title = ""
    
    var body: some View {
        NavigationView {
            VStack {
                
                switch categorySheetState {
                case .new: TextField("Enter name of new category",
                                     text: $category)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                case .edit: TextField("\(editCategory?.name ?? "")",
                                      text: $category)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                }
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
                case .new: title = "NEW"
                case .edit: title = "EDIT"
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
