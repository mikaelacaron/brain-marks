//
//  AddURLView.swift
//  brain-marks
//
//  Created by PRABALJIT WALIA     on 11/04/21.
//

import SwiftUI
import TelemetryClient
import UIKit

struct AddURLView: View {
    @State private var showingAlert = false
    @State private var selectedCategory: CategoryEntity
    @State var newEntry = ""
    @Environment(\.presentationMode) var presentationMode
    let categories: [CategoryEntity]
    
    @StateObject var viewModel = AddURLViewModel()
    
    let pasteBoard = UIPasteboard.general

    private let storageProvider = StorageProvider.shared

    init(categories: [CategoryEntity]) {
        self.categories = categories
        self._selectedCategory = State(initialValue: categories.first!)
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Enter copied url", text: $newEntry)
                    .autocapitalization(.none)
                Picker(selection: $selectedCategory , label: Text("Category"), content: {
                    ForEach(categories, id:\.self) { category in
                        Text(category.name ?? "No name").tag(category)
                    }
                })
            }
            .navigationBarItems(
                trailing: Button("Save") {
                    viewModel.fetchTweet(url: newEntry) { result in
                        switch result {
                        case .success(let tweet):
                                let tweetEntity = TweetEntity(context: storageProvider.context)
                                tweetEntity.authorName = tweet.authorName
                                tweetEntity.authorUsername = tweet.authorUsername
                                tweetEntity.dateCreated = Date()
                                tweetEntity.id = UUID()
                                tweetEntity.profileImageURL = tweet.profileImageURL
                                tweetEntity.text = tweet.text
                                tweetEntity.tweetID = tweet.id

                                // Category edits
                                selectedCategory.addToTweets(tweetEntity)
                                selectedCategory.dateModified = Date()

                                do {
                                    try storageProvider.context.save()
                                    TelemetryManager.send(TelemetrySignals.addTweet)
                                    presentationMode.wrappedValue.dismiss()
                                } catch {
                                    print("❌ AddURLView.save() Error: \(error)")
                                }
                        case .failure:
                                viewModel.alertItem = AlertContext.badURL
                        }
                    }
                })
        }
        .onAppear {
            DispatchQueue.main.async {
                newEntry = pasteBoard.string ?? ""
            }
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: Text(alertItem.title),
                  message: Text(alertItem.message),
                  dismissButton: alertItem.dismissButon)
            
        }
    }
}
