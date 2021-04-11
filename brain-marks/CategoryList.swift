//
//  CategoryList.swift
//  brain-marks
//
//  Created by Shloak Aggarwal on 11/04/21.
//

import SwiftUI

struct CategoryList: View {
    
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
                    Button("New Category") {
                        showingSheet.toggle()
                    }
                    .sheet(isPresented: $showingSheet) {
                        NewCategorySheetView()
                    }
                    
                    Spacer()
                    
                    Button("Add Tweet") {
                        
                    }
                }
            }
        }
        .onAppear {
            viewModel.getCategories()
        }
    }
}

struct NewCategorySheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var newCategory = ""
    
    var body: some View {
        NavigationView {
            VStack {
                
                TextField("Enter name of new category", text: $newCategory)
                
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
                        DataStoreManger.shared.createCategory(category: AWSCategory(name: newCategory, imageName: "swift"))
                    } label: {
                        Text("Create")
                            .frame(width: 150, height: 50)
                            .foregroundColor(.white)
                            .background(Color(UIColor(named: "twitter")!))
                            .font(.system(size: 20, weight: .semibold, design: .default))
                            .cornerRadius(10)
                    }
                }
                .padding(20)
            }
            .navigationBarTitle("New Category")
        }
    }
}

struct CategoryList_Previews: PreviewProvider {
    static var previews: some View {
        CategoryList()
        
        NewCategorySheetView()
    }
}
