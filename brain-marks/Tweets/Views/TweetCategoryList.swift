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

    @ObservedObject private var viewModel: TweetListViewModel

    @Environment(\.presentationMode) private var presentationMode

    // MARK: - Init
    init(tweet: AWSTweet, viewModel: TweetListViewModel) {
        self.tweet = tweet
        self.viewModel = viewModel
    }

    // MARK: - Body
    var body: some View {
        NavigationView {
            List { ForEach(viewModel.categories, content: categoryRow) }
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
