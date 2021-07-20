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
                
                TextField("Enter copied url", text: $newEntry)
                    .autocapitalization(.none)
                Picker(selection: $selectedCategory , label: Text("Category"), content: {
                    ForEach(categories,id:\.self) { category in
                        Text(category.name).tag(category.id)
                    }
                })
            }.navigationBarTitle("",displayMode: .inline)
            .navigationBarItems(
                trailing: Button("Save") {
                    if selectedCategory.name == "" {
                        print("Please select a CATEGORY")
                        showingAlert = true
                    } else {
                        viewModel.fetchTweet(url: newEntry) { result in
                            switch result {
                            case .success(let tweet):
                                
                                DataStoreManger.shared.fetchCategories { (result) in
                                    if case .success(_) = result {
                                        DataStoreManger.shared.createTweet(
                                            tweet: tweet,
                                            category: selectedCategory)
                                    }
                                    presentationMode.wrappedValue.dismiss()
                                }
                                
                            case .failure(let error):
                                print("❌ Couldn't save tweet: \(error)")
                            }
                        }
                    }
                })
        }
        .onAppear {
            newEntry = pasteBoard.string ?? ""
        }
        .onDisappear {
            selectedCategory.name = ""
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Uh Oh!"),
                  message: Text("You must select a category"),
                  dismissButton: .default(Text("Ok")))
        }
    }
}
