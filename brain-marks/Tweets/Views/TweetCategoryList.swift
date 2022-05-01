//
//  TweetCategoryList.swift
//  brain-marks
//
//  Created by Marlon Raskin on 4/28/22.
//

import SwiftUI

struct TweetCategoryList: View {

    // MARK: - Properties
    let tweet: AWSTweet

    @State private var selectedCategory: AWSCategory?
    @State private var moveAlertMessage = ""
    @State private var showingCategorySheet = false
    @State private(set) var newCategoryCreated = false

    @ObservedObject private var viewModel: TweetListViewModel

    @EnvironmentObject var categoryListViewModel: CategoryListViewModel
    @Environment(\.presentationMode) private var presentationMode

    // MARK: - Init
    init(tweet: AWSTweet, viewModel: TweetListViewModel) {
        self.tweet = tweet
        self.viewModel = viewModel
    }

    // MARK: - Body
    var body: some View {
        NavigationView {
            List {
                Section(content: categoryList, footer: categoryFooterView)
                Section(content: newCategoryButton)
            }
            .navigationTitle("Categories")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", action: dismiss)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save", action: saveTweetToCategory)
                        .disabled(selectedCategory == nil)
                }
            }
        }
        .onAppear { viewModel.getCategories(whileExcluding: tweet.category) }
    }

    // MARK: - Views
    private func categoryList() -> some View {
        ForEach(viewModel.categories, content: categoryRow)
    }

    private func categoryRow(category: AWSCategory) -> some View {
        HStack {
            Label(category.name, systemImage: category.imageName ?? "folder")
                .foregroundColor(.primary)
            Spacer()
            if category == selectedCategory {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            selectedCategory = category
        }
    }

    @ViewBuilder
    private func categoryFooterView() -> some View {
        if let category = tweet.category {
            HStack {
                Text("Currently in: ")
                Label(category.name, systemImage: category.imageName ?? "folder")
                    .foregroundColor(.accentColor)
                    .padding(.all, 4)
                    .background(Color.accentColor.opacity(0.1))
                    .cornerRadius(3)
                Spacer()
            }
        } else {
            Text("This tweet currently doesn't belong to any category.")
        }
    }

    private func createSheetView() -> CategorySheetView {
        CategorySheetView(
            newCategoryCreated: $newCategoryCreated,
            editCategory: .constant(nil),
            categorySheetState: .constant(.new),
            parentVM: categoryListViewModel
        )
    }

    private func newCategoryButton() -> some View {
        Button {
            showingCategorySheet = true
        } label: {
            Label("New Category", systemImage: "plus")
                .foregroundColor(.accentColor)
        }
        .sheet(isPresented: $showingCategorySheet, content: createSheetView)
        .onChange(of: showingCategorySheet) { showing in
            if !showing {
                if newCategoryCreated {
                    viewModel.updateNewCategoryCreated(newCategoryCreated)
                    viewModel.getCategories(whileExcluding: tweet.category)
                }
            }
        }
    }

    // MARK: - Helpers
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }

    private func saveTweetToCategory() {
        guard let selectedCategory = selectedCategory else { return }
        viewModel.move(tweet, to: selectedCategory) { result in
            switch result {
            case .success(let tweet):
                // Later we can show a success toast
                print("Moved tweet: \(tweet)")
                dismiss()
            case .failure(let error):
                // Later this message can be used for a failure toast
                moveAlertMessage = error.localizedDescription
            }
        }
    }
}

struct TweetCategoryList_Previews: PreviewProvider {
    static var previews: some View {
        TweetCategoryList(tweet: AWSTweet(tweetID: "tweet"), viewModel: TweetListViewModel())
    }
}
