//
//  AddURLView.swift
//  brain-marks
//
//  Created by PRABALJIT WALIA     on 11/04/21.
//

import SwiftUI
import UIKit

struct AddURLView: View {
    @State private var showingAlert = false
    @State private var selectedCategory = AWSCategory(name: "")
    @State var newEntry = ""
    @Environment(\.presentationMode) var presentationMode
    let categories: [AWSCategory]
    
    @StateObject var viewModel = AddURLViewModel()
    
    let pasteBoard = UIPasteboard.general
    
    var body: some View {
        NavigationView {
            Form {
                TextField("EnterCopiedURL", text: $newEntry)
                    .autocapitalization(.none)
                Picker(selection: $selectedCategory , label: Text("Category"), content: {
                    ForEach(categories,id:\.self) { category in
                        Text(category.name).tag(category.id)
                    }
                })
            }
            .navigationTitle(Text("Add Tweet URL"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    if selectedCategory.name == "" {
                        viewModel.alertItem = AlertContext.noCategory
                        showingAlert = true
                    } else {
                        viewModel.fetchTweet(url: newEntry) { result in
                            switch result {
                            case .success(let tweet):
                                
                                DataStoreManger.shared.fetchCategories { (result) in
                                    if case .success = result {
                                        DataStoreManger.shared.createTweet(
                                            tweet: tweet,
                                            category: selectedCategory)
                                    }
                                    presentationMode.wrappedValue.dismiss()
                                }
                                
                            case .failure:
                                viewModel.alertItem = AlertContext.badURL
                            }
                        }
                    }
                })
        }
        .onAppear {
            DispatchQueue.main.async {
                newEntry = pasteBoard.string ?? ""
            }
        }
        .onDisappear {
            selectedCategory.name = ""
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: Text(alertItem.title),
                  message: Text(alertItem.message),
                  dismissButton: alertItem.dismissButon) 
        }
    }
}
