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
                Picker(selection: $selectedCategory , label: Text("Category")) {
                    ForEach(categories,id:\.self) { category in
                        Text(category.name).tag(category.id)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("AddTweetURL").bold()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if selectedCategory.name == "" {
                            viewModel.alertItem = AlertContext.noCategory
                            showingAlert = true
                            
                        } else {
                            Task(priority: .userInitiated) {
                                do {
                                    let tweet = try await viewModel.fetchTweet(url: newEntry)
                                    
                                    DataStoreManger.shared.fetchCategories { (result) in
                                        if case .success = result {
                                            DataStoreManger.shared.createTweet(
                                                tweet: tweet,
                                                category: selectedCategory)
                                        }
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                } catch {
                                   viewModel.alertItem = AlertContext.badURL
                                }
                            }
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }.onAppear {
            if let firstCategory = categories.first {
                selectedCategory = firstCategory
            }

            DispatchQueue.main.async {
                newEntry = pasteBoard.string ?? ""
            }
        }.onDisappear {
            selectedCategory.name = ""
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: Text(alertItem.title),
                  message: Text(alertItem.message),
                  dismissButton: alertItem.dismissButon)
        }
    }
}
