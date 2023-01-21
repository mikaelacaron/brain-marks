//
//  CategorySheetView.swift
//  brain-marks
//
//  Created by Mikaela Caron on 5/1/21.
//

import SwiftUI
import TelemetryClient

struct CategorySheetView: View {
    
    @Binding var editCategory: CategoryEntity?
    @Binding var categorySheetState: CategoryState
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var category = ""
    @State private var title = ""

    private let storageProvider = StorageProvider.shared
    
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
                        if !category.isEmpty {
                            
                            switch categorySheetState {
                            case .new:
                                addNewCategory()
                            case .edit:
                                performEdit()
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

    func addNewCategory() {
        let newCategory = CategoryEntity(context: storageProvider.context)
        newCategory.id = UUID()
        newCategory.dateCreated = Date()
        newCategory.dateModified = Date()
        newCategory.name = category
        newCategory.imageName = "folder"

        do {
            try storageProvider.context.save()
            TelemetryManager.send(TelemetrySignals.addCategory)
            presentationMode.wrappedValue.dismiss()
        } catch {
            print("❌ CategorySheetView.addNewCategory: \(error)")
        }
    }

    func performEdit() {
        guard let editCategory else {
            return
        }
        editCategory.dateModified = Date()
        editCategory.name = category

        do {
            try storageProvider.context.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print("❌ CategorySheetView.performEdit() error: \(error)")
        }
    }
}

struct NewCategorySheetView_Previews: PreviewProvider {
    static var previews: some View {
        CategorySheetView(
            editCategory: .constant(
                StorageProvider.preview.getAllCategories()[1]
            ),
            categorySheetState: .constant(.edit)
        )
    }
}
